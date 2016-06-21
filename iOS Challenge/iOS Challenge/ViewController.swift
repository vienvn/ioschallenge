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
  
  var data: [UpcomingGuides] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    tableView.delegate = self
    tableView.dataSource = self
//    tableView.registerClass(UpcomingTableViewCell.self, forCellReuseIdentifier: "cell")
    
    Service.sharedInstance.getUpcomingGuides { (data) in
      self.data = data
      self.tableView.reloadData()
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension ViewController: UITableViewDelegate {
  
}

extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("UpcomingCell")! as! UpcomingTableViewCell
    
    if let nameLable = cell.viewWithTag(100) as? UILabel {
      nameLable.text = data[indexPath.row].name
    }
    
    if let cityLable = cell.viewWithTag(200) as? UILabel {
      cityLable.text = data[indexPath.row].city
    }
    
    if let stateLable = cell.viewWithTag(400) as? UILabel {
      stateLable.text = data[indexPath.row].state
    }
    
    if let endLable = cell.viewWithTag(300) as? UILabel {
      endLable.text = "\(data[indexPath.row].endDate!)"
    }

//    cell.textLabel?.text = data[indexPath.row].name
    
    return cell
  }
}