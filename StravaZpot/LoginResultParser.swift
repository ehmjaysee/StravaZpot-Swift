//
//  LoginResultParser.swift
//  StravaZpot
//
//  Created by Tomás Ruiz López on 26/7/17.
//  Copyright © 2017 SweetZpot AS. All rights reserved.
//

import Foundation
import SwiftyJSON

#if false //mjc

public class LoginResultParser : Parser {
    public func from(json: JSON) -> LoginResult {
        return LoginResult(token: json["access_token"].token!,
                           athlete: json["athlete"].athlete!)
    }
}

#else

public class LoginResultParser : Parser {
    public func from(json: JSON) -> LoginResult {
        return LoginResult(
            token: json["access_token"].token!,
            athlete: json["athlete"].athlete!,
            expiresAt: json["expires_at"].int!,
            expiresIn: json["expires_in"].int!,
            refreshToken: json["refresh_token"].token!)
    }
}

#endif

