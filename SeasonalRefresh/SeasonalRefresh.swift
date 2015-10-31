//
//  SeasonalRefresh.swift
//  SeasonalRefresh
//
//  Created by 田中賢治 on 2015/10/31.
//  Copyright © 2015年 田中賢治. All rights reserved.
//

import UIKit

enum Season {
    case Halloween, Christmas, NewYear, Valentine
}

protocol SeasonalRefreshDelegate {
    
}

class SeasonalRefresh: NSObject {
    var season: Season?
    var delegate: SeasonalRefreshDelegate?
    weak var scrollView: UIScrollView?
    
    var refreshView: SeasonalRefreshView?
    
    var action: (()->())?
    
    func startRefreshing() {
        
    }
    
    func endRefreshing() {
        
    }
}
