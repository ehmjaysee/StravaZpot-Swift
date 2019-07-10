//
//  AuthenticationRequest.swift
//  StravaZpot
//
//  Created by Tomás Ruiz López on 26/7/17.
//  Copyright © 2017 SweetZpot AS. All rights reserved.
//

import Foundation

public class AuthenticationRequest : PostRequest<LoginResult> {
    private let parameters : [String : Any]
    
    init(client : HTTPClient, appCredentials : AppCredentials, code : String) {
        parameters = ["client_id" : appCredentials.clientID, "client_secret" : appCredentials.clientSecret, "code" : code, "grant_type" : "authorization_code"]  //mjc Added authorization_code
        super.init(client : client, url : "oauth/token", parse : { $0.loginResult })
    }
    
    override func getParameters() -> [String : Any] {
        return parameters
    }
}

//mjc Added this function so we can refresh expired tokens
public class AuthRefreshRequest : PostRequest<LoginResult> {
    private let parameters : [String : Any]
    
    init(client : HTTPClient, appCredentials : AppCredentials, token : String) {
        parameters = ["client_id" : appCredentials.clientID, "client_secret" : appCredentials.clientSecret, "refresh_token" : token, "grant_type" : "refresh_token"]  //mjc
        super.init(client : client, url : "oauth/token", parse : { $0.loginResult })
    }
    
    override func getParameters() -> [String : Any] {
        return parameters
    }
}

