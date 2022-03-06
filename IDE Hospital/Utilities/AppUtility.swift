//
//  AppUtility.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/20/20.
//

import UIKit

//MARK:- Google Map Functions
struct AppUtility {
    static func openGoogleMap(lat: Float, lng: Float) {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(lat),\(lng)&directionsmode=driving") {
                UIApplication.shared.open(url, options: [:])
            }
        } else {
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(lng)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
            }
        }
    }
    static func formattedDate(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy, HH:mm a"
        return dateFormatter.string(from: date)
    }
}
