//
//  ListClubGroupEventsRequest.swift
//  StravaZpot
//
//  Created by Tomás Ruiz López on 7/11/16.
//  Copyright © 2016 SweetZpot AS. All rights reserved.
//

import Foundation

public class ListClubGroupEventsRequest : GetRequest<EquatableArray<Event>> {
    init(client : HTTPClient, id : Int) {
        super.init(client: client, url: "clubs/\(id)/group_events", parse: { $0.eventArray })
    }
}
