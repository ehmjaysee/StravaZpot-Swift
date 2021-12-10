//
//  JSONExtension.swift
//  StravaZpot
//
//  Created by Tomás Ruiz López on 2/11/16.
//  Copyright © 2016 SweetZpot AS. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON {
    
    public func isNonNull() -> Bool {
        return exists() && (type != .null)
    }
    
    var achievementType : AchievementType? {
        return isNonNull() ? AchievementTypeParser().from(json: self) : nil
    }
    
    var resourceState : ResourceState? {
        return isNonNull() ? ResourceStateParser().from(json: self) : ResourceState.meta
    }
    
    var activity : Activity? {
        return isNonNull() ? ActivityParser().from(json: self) : nil
    }
    
    var activityArray : EquatableArray<Activity>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.activity }) : nil
    }
    
    var athlete : Athlete? {
        return isNonNull() ? AthleteParser().from(json: self) : nil
    }
    
    var athleteArray : EquatableArray<Athlete>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.athlete }) : nil
    }
    
    var time : Time? {
        return isNonNull() ? TimeParser().from(json: self) : nil
    }
    
    var date : Date? {
        return isNonNull() ? DateParser().from(json: self) : nil
    }
    
    var dateArray : EquatableArray<Date>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.date }) : nil
    }
    
    var distance : Distance? {
        return isNonNull() ? DistanceParser().from(json: self) : nil
    }
    
    var speed : Speed? {
        return isNonNull() ? SpeedParser().from(json: self) : nil
    }
    
    var activityType : ActivityType? {
        return isNonNull() ? ActivityTypeParser().from(json: self) : nil
    }
    
    var coordinates : Coordinates? {
        return isNonNull() ? CoordinatesParser().from(json: self) : nil
    }
    
    var photoSummary : PhotoSummary? {
        return isNonNull() ? PhotoSummaryParser().from(json: self) : nil
    }
    
    var map : Map? {
        return isNonNull() ? MapParser().from(json: self) : nil
    }
    
    var workoutType : WorkoutType? {
        return isNonNull() ? WorkoutTypeParser().from(json: self) : nil
    }
    
    var gear : Gear? {
        return isNonNull() ? GearParser().from(json: self) : nil
    }
    
    var gearArray : EquatableArray<Gear>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.gear }) : nil
    }
    
    var temperature : Temperature? {
        return isNonNull() ? TemperatureParser().from(json: self) : nil
    }
    
    var split : Split? {
        return isNonNull() ? SplitParser().from(json: self) : nil
    }
    
    var splitArray : EquatableArray<Split>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.split }) : nil
    }
    
    var segmentEffort : SegmentEffort? {
        return isNonNull() ? SegmentEffortParser().from(json: self) : nil
    }
    
    var segmentEffortArray : EquatableArray<SegmentEffort>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.segmentEffort }) : nil
    }
    
    var gender : Gender? {
        return isNonNull() ? GenderParser().from(json: self) : nil
    }
    
    var friendStatus : FriendStatus? {
        return isNonNull() ? FriendStatusParser().from(json: self) : nil
    }
    
    var athleteType : AthleteType? {
        return isNonNull() ? AthleteTypeParser().from(json: self) : nil
    }
    
    var measurementPreference : MeasurementPreference? {
        return isNonNull() ? MeasurementPreferenceParser().from(json: self) : nil
    }
    
    var club : Club? {
        return isNonNull() ? ClubParser().from(json: self) : nil
    }
    
    var clubArray : EquatableArray<Club>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.club }) : nil
    }
    
    var clubType : ClubType? {
        return isNonNull() ? ClubTypeParser().from(json: self) : nil
    }
    
    var skillLevel : SkillLevel? {
        return isNonNull() ? SkillLevelParser().from(json: self) : nil
    }
    
    var terrain : Terrain? {
        return isNonNull() ? TerrainParser().from(json: self) : nil
    }
    
    var frameType : FrameType? {
        return isNonNull() ? FrameTypeParser().from(json: self) : nil
    }
    
    var interval : Interval<Double>? {
        return isNonNull() ? IntervalDoubleParser().from(json: self) : nil
    }
    
    var intervalArray : EquatableArray<Interval<Double>>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.interval }) : nil
    }
    
    var membership : Membership? {
        return isNonNull() ? MembershipParser().from(json: self) : nil
    }
    
    var leaderboardEntry : LeaderboardEntry? {
        return isNonNull() ? LeaderboardEntryParser().from(json: self) : nil
    }
    
    var leaderboardEntryArray : EquatableArray<LeaderboardEntry>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.leaderboardEntry }) : nil
    }
    
    var photoSource : PhotoSource? {
        return isNonNull() ? PhotoSourceParser().from(json: self) : nil
    }
    
    var primaryPhoto : PrimaryPhoto? {
        return isNonNull() ? PrimaryPhotoParser().from(json: self) : nil
    }
    
    var imageURLs : [String : String]? {
        let pairs : [(String, String)] = self.map { key, value in (key, value.string!) }
        var urls = [String : String]()
        pairs.forEach{ urls[$0.0] = $0.1 }
        return urls
    }
    
    var routeType : RouteType? {
        return isNonNull() ? RouteTypeParser().from(json: self) : nil
    }
    
    var routeSubtype : RouteSubtype? {
        return isNonNull() ? RouteSubtypeParser().from(json: self) : nil
    }
    
    var segment : Segment? {
        return isNonNull() ? SegmentParser().from(json: self) : nil
    }
    
    var segmentArray : EquatableArray<Segment>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.segment }) : nil
    }
    
    var percentage : Percentage? {
        return isNonNull() ? PercentageParser().from(json: self) : nil
    }
    
    var totals : Totals? {
        return isNonNull() ? TotalsParser().from(json: self) : nil
    }
    
    var streamType : StreamType? {
        return isNonNull() ? StreamTypeParser().from(json: self) : nil
    }
    
    var seriesType : SeriesType? {
        return isNonNull() ? SeriesTypeParser().from(json: self) : nil
    }
    
    var resolution : Resolution? {
        return isNonNull() ? ResolutionParser().from(json: self) : nil
    }
    
    var heartRate : HeartRate? {
        return isNonNull() ? HeartRateParser().from(json: self) : nil
    }
    
    var power : Power? {
        return isNonNull() ? PowerParser().from(json: self) : nil
    }
    
    var timedInterval : TimedInterval<Double>? {
        return isNonNull() ? TimedDoubleIntervalParser().from(json: self) : nil
    }
    
    var timedIntervalArray : EquatableArray<TimedInterval<Double>>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.timedInterval }) : nil
    }
    
    var zones : Zones? {
        return isNonNull() ? ZonesParser().from(json: self) : nil
    }
    
    var zonesArray : EquatableArray<Zones>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.zones }) : nil
    }
    
    var stats : Stats? {
        return isNonNull() ? StatsParser().from(json: self) : nil
    }
    
    var activityZone : ActivityZone? {
        return isNonNull() ? ActivityZoneParser().from(json: self) : nil
    }
    
    var activityZoneArray : EquatableArray<ActivityZone>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.activityZone }) : nil
    }
    
    var activityLap : ActivityLap? {
        return isNonNull() ? ActivityLapParser().from(json: self) : nil
    }
    
    var activityLapArray : EquatableArray<ActivityLap>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.activityLap }) : nil
    }
    
    var photo : Photo? {
        return isNonNull() ? PhotoParser().from(json: self) : nil
    }
    
    var photoArray : EquatableArray<Photo>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.photo }) : nil
    }
    
    var comment : Comment? {
        return isNonNull() ? CommentParser().from(json: self) : nil
    }
    
    var commentArray : EquatableArray<Comment>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.comment }) : nil
    }
    
    var announcement : Announcement? {
        return isNonNull() ? AnnouncementParser().from(json: self) : nil
    }
    
    var announcementArray : EquatableArray<Announcement>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.announcement }) : nil
    }
    
    var event : Event? {
        return isNonNull() ? EventParser().from(json: self) : nil
    }
    
    var eventArray : EquatableArray<Event>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.event }) : nil
    }
    
    var joinResult : JoinResult? {
        return isNonNull() ? JoinResultParser().from(json: self) : nil
    }
    
    var leaveResult : LeaveResult? {
        return isNonNull() ? LeaveResultParser().from(json: self) : nil
    }
    
    var route : Route? {
        return isNonNull() ? RouteParser().from(json: self) : nil
    }
    
    var routeArray : EquatableArray<Route>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.route }) : nil
    }
    
    var leaderboard : Leaderboard? {
        return isNonNull() ? LeaderboardParser().from(json: self) : nil
    }
    
    var stream : Stream? {
        return isNonNull() ? StreamParser().from(json: self) : nil
    }
    
    var streamArray : EquatableArray<Stream>? {
        return isNonNull() ? EquatableArray(array: self.compactMap{ $1.stream }) : nil
    }
    
    var uploadStatus : UploadStatus? {
        return isNonNull() ? UploadStatusParser().from(json: self) : nil
    }
    
    var token : Token? {
        return isNonNull() ? TokenParser().from(json: self) : nil
    }
    
    var loginResult : LoginResult? {
        return isNonNull() ? LoginResultParser().from(json: self) : nil
    }
    
    var exploreResult : ExploreResult? {
        return isNonNull() ? ExploreResultParser().from(json: self) : nil
    }
}
