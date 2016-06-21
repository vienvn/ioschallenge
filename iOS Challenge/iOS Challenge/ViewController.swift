//
//  ViewController.swift
//  iOS Challenge
//
//  Created by iOS Dev on 6/21/16.
//  Copyright © 2016 iOS Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var data: [[UpcomingGuides]] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 88.0
    
    Service.sharedInstance.getUpcomingGuides { (data) in
      self.data = self.groupUpcoming(data)
      self.tableView.reloadData()
    }
  }
  
  func groupUpcoming(data: [UpcomingGuides]) -> [[UpcomingGuides]] {
    let dataSorted = data.sort({ $0.startDate.compare($1.startDate) == NSComparisonResult.OrderedAscending })
    
    var list: [[UpcomingGuides]] = []
    
    var tmpDate = NSDate(timeIntervalSince1970: 0)
    var tmpList: [UpcomingGuides] = []
    
    for item in dataSorted {
      if item.startDate.compare(tmpDate) == NSComparisonResult.OrderedSame {
        tmpList.append(item)
      } else {
        if tmpList.count != 0 {
          list.append(tmpList)
          tmpList = []
        }
        tmpList.append(item)
      }
      tmpDate = item.startDate
    }
    list.append(tmpList)
    return list
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension ViewController: UITableViewDelegate {
  
}

extension ViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return data.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data[section].count
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    
    return "\(dateFormatter.stringFromDate((data[section][0].startDate)))"
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCellWithIdentifier("UpcomingCell")! as! UpcomingTableViewCell
    
    
    if let nameLable = cell.viewWithTag(100) as? UILabel {
      nameLable.text = data[indexPath.section][indexPath.row].name
    }
    
    if let cityLable = cell.viewWithTag(200) as? UILabel {
      cityLable.text = data[indexPath.section][indexPath.row].city
    }
    
    if let stateLable = cell.viewWithTag(400) as? UILabel {
      stateLable.text = data[indexPath.section][indexPath.row].state
    }
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    let endDate = data[indexPath.section][indexPath.row].endDate!
    if let endLable = cell.viewWithTag(300) as? UILabel {
      endLable.text = "\(dateFormatter.stringFromDate(endDate))"
    }
    
    return cell
  }
}