//
//  Service.swift
//  iOS Challenge
//
//  Created by iOS Dev on 6/21/16.
//  Copyright © 2016 iOS Dev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Service {
  static let sharedInstance = Service()
  
  let URLString = "https://www.guidebook.com/service/v2/upcomingGuides/"
  
  func getUpcomingGuides() -> [UpcomingGuides]? {
    var list: [UpcomingGuides] = []
    Alamofire.request(.GET, URLString).validate().responseJSON { response in
      switch response.result {
      case .Success(let data):
        let json = JSON(data)
        let upcomings = json["data"].array
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        for obj in upcomings! {
          let name = obj["name"].string!
          let city: String? = obj["venue"]["city"].string
          let state: String? = obj["venue"]["state"].string
          let startDate = dateFormatter.dateFromString(obj["startDate"].string!)
          let endDate = dateFormatter.dateFromString(obj["endDate"].string!)
          
          print("\(name) \(city) \(state) \(startDate) \(endDate) ")
          list.append(UpcomingGuides(name: name, city: city, state: state, startDate: startDate!, endDate: endDate!))
        }
      case .Failure(let error):
        print("Request failed with error: \(error)")
      }
    }
  
    return nil
  }
}