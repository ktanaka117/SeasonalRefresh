//
//  UIScrollView+SeasonalRefresh.swift
//  SeasonalRefresh
//
//  Created by 田中賢治 on 2015/10/31.
//  Copyright © 2015年 田中賢治. All rights reserved.
//

import UIKit

extension UIScrollView {
    var seasonalRefresh: SeasonalRefresh? {
        get { return self.seasonalRefresh }
        set(newValue) { self.seasonalRefresh = newValue }
    }
    
    func addSeasonalRefresh(season: Season, action: ()->()) {
//        if self.seasonalRefresh != nil {
//            self.removeSeasonalRefresh(seasonalRefresh!)
//        }
        
        self.seasonalRefresh = SeasonalRefresh(season: season)
        self.seasonalRefresh?.refreshView = SeasonalRefreshView()
        self.seasonalRefresh?.refreshView?.delegate = seasonalRefresh
        self.seasonalRefresh!.scrollView = self
        self.seasonalRefresh!.action = action
        
        let view = seasonalRefresh!.refreshView
        view?.frame = CGRectMake(0, -view!.frame.size.height, self.frame.size.width, view!.frame.size.height)
        self.addSubview(view!)
        self.sendSubviewToBack(view!)
    }
    
    func removeSeasonalRefresh(seasonalRefresh: SeasonalRefresh) {
        self.seasonalRefresh?.refreshView?.removeFromSuperview()
        self.seasonalRefresh = nil
    }
    
    func startRefreshing() {
        seasonalRefresh?.startRefreshing()
    }
    
    func endRefreshing() {
        seasonalRefresh?.endRefreshing()
    }
}