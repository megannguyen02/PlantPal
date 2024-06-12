//
//  CloudData.swift
//  Plant-Pal
//
//  Created by Megan Nguyen on 6/11/24.
//

import Foundation
import AWSCloudWatchLogs


class CloudData {
    static func retrieveLogsFromCloudWatch() {
        let cloudWatch = AWSCloudWatch.default()
        let request = AWSCloudWatchLogsFilterLogEventsRequest()
        
        cloudWatch.filterLogEvents(request) { response, error in
            if let error = error {
                print("Error retrieving logs:", error.localizedDescription)
                return
            }

            if let events = response?.events {
                for event in events {
                    // Process each log event
                    print("Log Event:", event.message ?? "No message")
                }
            }
            
        }
    }
}
