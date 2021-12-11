# StravaZpot Swift

A fluent API to integrate with Strava on iOS apps written in Swift.

This document explains how to use **StravaZpot** in your Swift iOS app. For additional questions, you may want to check **Strava** official documentation [here](https://strava.github.io/api/).

## Repo History

The original repo (SweetzpotAS/StravaZpot-Swift) is now archived. This fork was created in order to continue using this great library with modern iOS apps. Some of the changes made to this fork include:
1) Support SwifyJSON 5x
2) Support xcode 13.0
3) Support iOS 13.0
4) Support Swift 5
5) Fix crashes when Strava does not return data for optional activity properties 
6) Support Strava OAUTH authentication

## Installation

You can get **StravaZpot** from CocoaPods. Just add this line to your Podfile:

```ruby
pod 'StravaZpot-Swift', :git => 'https://github.com/ehmjaysee/StravaZpot-Swift.git'
```
 
## Authentication

Your app needs permission to access to the user's Strava account. To do this you will need permission from both Strava and the user. 

First you must request permission from Strava. You will need to log into your own Strava account (or create a new one) and then navigate to the [Strava API page](https://www.strava.com/settings/api) and make the request. Strava will grant the request and provide you a 'Client ID' and 'Client Secret'. 

Next you will need permission from the user in order to access their account. There are two ways to request this permission. You can send the request directly to the Strava app (if already installed on the device) or or you can send the request to a web browser. If the user is already logged into their Strava account they will be presented with a page explaining what is being requested and how to grant access. Once the user grants permission Strava will send the OAUTH token back to your app. Your app will receive this token in your AppDelegate. Your app must use this token to request a login session with the Strava server. 

Here is sample code to make the request:
  
```swift
// Get these from https://www.strava.com/settings/api
let stravaClientID = 12345
let stravaSecret = "6500920935098436098349823478234"

// URL for sending the request to the Strava app installed on the user's device
let stravaLocalAuth = "strava://oauth/mobile/authorize?response_type=code&state=ios"

// URL for sending the request to a web browser
let stravaRemoteAuth = "https://www.strava.com/oauth/mobile/authorize?response_type=code&state=ios"

// Replace this value with your app's URL scheme
let stravaRedirectURL = "YourAppCodeHere://YourDomainHere"

// Adjust these for your app's required permissions
let stravaApproval = "force"
let stravaScope = "read,read_all,activity:read_all,activity:write"

// Check if strava app is install on the device
let localAuth = stravaLocalAuth + "&client_id=\(stravaClientID)" + "&redirect_uri=\(stravaRedirectURL)" + "&approval_prompt=\(stravaApproval)" + "&scope=\(stravaScope)"
if let url = URL(string: localAuth), UIApplication.shared.canOpenURL(url) {
    UIApplication.shared.open(url)
    return
}

// Send the request to a web browser
let remoteAuth = stravaRemoteAuth + "&client_id=\(stravaClientID)" + "&redirect_uri=\(stravaRedirectURL)" + "&approval_prompt=\(stravaApproval)" + "&scope=\(stravaScope)"
if let url = URL(string: remoteAuth) {
    UIApplication.shared.open(url)
    return
}
```

The example code above will present the user with a UI to grant permissions. When the user grants permission Strava will send a code to your app. Prepare your app to receive the response in your AppDelegate.

```swift
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool
    {
        if let stravaCode = url.valueOf(queryParameterName: "code") {
            // Do something with the code here
        }
    }
```

Your app can use this code to create a new HTTP client:    

```swift
let client = HTTPClientBuilder.authenticationClient(debug: stravaDebug)
let credentials = AppCredentials(clientID: stravaClientID, clientSecret: stravaSecret)
let authAPI = AuthenticationAPI(client: client)
let authReq = authAPI.getToken(forApp: credentials, withCode: stravaCode)   // stravaCode was received in AppDelegate

authReq.execute(callback: { ( result: StravaResult<LoginResult> ) -> Void in
    switch result {
    case .error(let err):
        // why me
    case .success(let loginResult):
        // We just received a shiny new loginResult which includes a token.
        self.loginResult = loginResult  // cache it
        // Use the new loginResult to create a new HTTP client
        if let token = loginResult?.token.description {
            self.client = HTTPClientBuilder.client(withToken: token, debug: stravaDebug)
        }
    }
})
```

This is the end of authentication. You now have the HTTP client instance which is required by all API calls.

## Usage

All responses from Strava API calls are wrapped in `StravaResult<T>`, which is an enum that indicates if the result was successful or not. The successful case contains an instance of the object that Strava returns. The failure case contains an `Error` explaining the reason for the failure.

### Usage example:

```swift
// Download a single activity
let activityAPI = ActivityAPI(client: client)
let request = activityAPI.retrieveActivity(withID: activityID, includeAllEfforts: true)
request.execute(callback: { (result: StravaResult<Activity>) -> Void in
    switch result {
    case .error(let err):
    case .success(let activity):
        if let name = activity.name, let segments = activity.segmentEfforts
        {
            // We got a valid strava activity from the server.
            print("Activity: " + name + " segments: \(segments.array.count)")
        }
    }
})
```

### Upload a file to Strava

Strava allows you to upload files with formats GPX, FIT or TCX. You must provide the file URL and associated meta data in the API call.  

```swift
let uploadAPI = UploadAPI(client: client)
let activityType: UploadActivityType.ride

let request = uploadAPI.upload(
    file: url,
    withFilename: "Your File Name",
    withDataType: .gpx,
    withActivityType: activityType,
    withName: "Your activity name",         
    withDescription: "Recorded by my awesome app",
    isPrivate: false,
    hasTrainer: false,
    isCommute: false,
    withExternalID: "your external ID")
    
request.execute() { ( result: StravaResult<UploadStatus> ) -> Void in
    switch result {
    case .error(let err):
        // do something
    case .success(let status):
        // The response message will include the upload ID.  Cache it.
        self.uploadID = status.id
    }}
```

If the call is successful you will receive a unique uploadID. Use that ID for polling the server to determine when the upload is complete.

```swift
let uploadAPI = UploadAPI(client: client)
let request = uploadAPI.checkUploadStatus(withId: id)
request.execute(callback: { (result: StravaResult<UploadStatus>) -> Void in
    switch result {
    case .error(let err):
        // do something
    case .success(let status):
        if let activityID = status.activityID {
            self.activityID = activityID  // cache it
        }
    }
})
```

Now you have a new activityID for the uploaded content. Use this ID to download all the activity details including segments. Note the server may take a minute or so to find all the segments in the new recording. There is no indication from the server when it finishes searching for segments. You will simply need to monitor the new activity and wait for the number of segments to stop increasing.  

## License

    Copyright 2017 SweetZpot AS

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
