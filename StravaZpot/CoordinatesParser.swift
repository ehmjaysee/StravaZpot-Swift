//
//  CoordinatesParser.swift
//  StravaZpot
//
//  Created by Tomás Ruiz López on 28/10/16.
//  Copyright © 2016 SweetZpot AS. All rights reserved.
//

import Foundation
import SwiftyJSON

public class CoordinatesParser : Parser {
    public func from(json: JSON) -> Coordinates? {
        if let values = json.array, values.count >= 2 {
            return Coordinates(latitude: values[0].double ?? 0.0, longitude: values[1].double ?? 0.0)
        } else {
            return nil
        }
    }
}
