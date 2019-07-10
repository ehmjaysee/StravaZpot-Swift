//
//  LoginResult.swift
//  StravaZpot
//
//  Created by Tomás Ruiz López on 26/7/17.
//  Copyright © 2017 SweetZpot AS. All rights reserved.
//

import Foundation

#if false  //mjc

public struct LoginResult {
    public let token : Token
    public let athlete : Athlete
}

#else

public struct LoginResult {
    public let token : Token
    public let athlete : Athlete
    public let expiresAt : Int
    public let expiresIn : Int
    public let refreshToken : Token
}

#endif

extension LoginResult : Equatable {}

public func ==(lhs : LoginResult, rhs : LoginResult) -> Bool {
    return lhs.token == rhs.token &&
            lhs.athlete == rhs.athlete
}

