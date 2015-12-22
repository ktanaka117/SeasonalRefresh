//
//  ViewController.swift
//  SeasonalRefresh
//
//  Created by 田中賢治 on 2015/10/31.
//  Copyright © 2015年 田中賢治. All rights reserved.
//

import UIKit

let cellIdentifier = "Cell"

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        tableView.addSeasonalRefresh(.Halloween, action: { [weak self] in
            for var i = 0; i < 10000; i++ {
                print(i)
            }
            
            self?.tableView.seasonalRefresh?.endRefreshing()
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        cell?.backgroundColor = UIColor.cyanColor()
        
        return cell!
    }
    
}

