//
//  DateParser.swift
//  StravaZpot
//
//  Created by Tomás Ruiz López on 31/10/16.
//  Copyright © 2016 SweetZpot AS. All rights reserved.
//

import Foundation
import SwiftyJSON

public class DateParser : Parser {
    public func from(json: JSON) -> Date {
        #if true
        //mjc
        // The code below is causing a crash for a customer in the UK for some reason.
        // MotionIQ does not use the date so a quick fix is to return today's date.
        return Date()
        #else
        let dateString = json.string!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormatter.date(from: dateString)!
        #endif
    }
}
