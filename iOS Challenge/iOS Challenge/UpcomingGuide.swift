//
//  UpcomingGuide.swift
//  iOS Challenge
//
//  Created by iOS Dev on 6/21/16.
//  Copyright © 2016 iOS Dev. All rights reserved.
//

import Foundation

class UpcomingGuides {
  var name: String!
  var city: String?
  var state: String?
  var startDate: NSDate!
  var endDate: NSDate!
  
  init(name: String, city: String?, state: String?, startDate: NSDate, endDate: NSDate) {
    self.name = name
    self.city = city
    self.state = state
    self.startDate = startDate
    self.endDate = endDate
  }
  
  func generatesFromJSON(jsonObject: AnyObject) {
    if let object = jsonObject as? [String: AnyObject] {
      if let name = object["name"] as? String {
        self.name = name
      }
    
      if let city = object["city"] as? String {
        self.city = city
      }
      
      if let state  = object["state"] as? String {
        self.state   = state
      }
      
      if let startDate = object["startDate"] as? NSDate {
        self.startDate = startDate
      }
      
      if let endDate = object["endDate"] as? NSDate {
        self.endDate = endDate
      }
    }
  }
}