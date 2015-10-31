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

private var KVOContext = "RefresherKVOContext"
private let ContentOffsetKeyPath = "contentOffset"

class SeasonalRefresh: NSObject, SeasonalRefreshViewDelegate {
    var season: Season?
    
    weak var scrollView: UIScrollView?
    
    var refreshView: SeasonalRefreshView = SeasonalRefreshView()
    var type: Season = .Halloween
    
    var action: (()->())?
    
    init(season: Season) {
        self.season = season
    }
    
    func startRefreshing() {
        
    }
    
    func endRefreshing() {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if let seasonalRefreshView = scrollView.viewWithTag(seasonalRefreshViewTag) {
            seasonalRefreshView.frame.origin.y = -200
            
            if seasonalRefreshView.frame.origin.y - scrollView.contentOffset.y > 0 {
                scrollView.contentOffset.y = 0
                scrollView.scrollEnabled = false
                scrollView.scrollEnabled = true
            }
        }
    }
    
    // MARK: -SeasonalRefreshViewDelegate
    func seasonalRefreshViewWillMoveToSuperView(newSuperView: UIView?) {
//        if scrollView?.observationInfo != nil {
//            scrollView?.removeObserver(self, forKeyPath: ContentOffsetKeyPath, context: &KVOContext)
//        }
        if let scrollView = newSuperView as? UIScrollView {
            scrollView.addObserver(self, forKeyPath: ContentOffsetKeyPath, options: .Initial, context: &KVOContext)
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (context == &KVOContext && keyPath == ContentOffsetKeyPath && object as? UIScrollView == scrollView) {
            scrollViewDidScroll(scrollView!)
        }
        else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
}
