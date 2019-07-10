//
//  UploadStatus.swift
//  StravaZpot
//
//  Created by Tomás Ruiz López on 24/7/17.
//  Copyright © 2017 SweetZpot AS. All rights reserved.
//

import Foundation

//mjc added 'public' to the structure elements
public struct UploadStatus {
    public let id : Int
    public let externalID : String?
    public let error : String?
    public let status : String?
    public let activityID : Int?
}

extension UploadStatus : Equatable {}

public func ==(lhs : UploadStatus, rhs : UploadStatus) -> Bool {
    return  lhs.id         == rhs.id &&
            lhs.externalID == rhs.externalID &&
            lhs.error      == rhs.error &&
            lhs.status     == rhs.status &&
            lhs.activityID == rhs.activityID
}
