//
//  UIScrollView+SeasonalRefresh.swift
//  SeasonalRefresh
//
//  Created by 田中賢治 on 2015/10/31.
//  Copyright © 2015年 田中賢治. All rights reserved.
//

import UIKit
import ObjectiveC

private var associatedObjectHandle: UInt8 = 0
let seasonalRefreshViewTag = 98789

extension UIScrollView {
    private var seasonalRefresh: SeasonalRefresh? {
        get {
            return objc_getAssociatedObject(self, &associatedObjectHandle) as? SeasonalRefresh
        }
        set {
            objc_setAssociatedObject(self, &associatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func addSeasonalRefresh(season: Season, action: ()->()) {
        self.seasonalRefresh = SeasonalRefresh(season: season)
        self.seasonalRefresh?.refreshView.delegate = seasonalRefresh
        self.seasonalRefresh!.scrollView = self
        self.seasonalRefresh!.action = action
        
        let view = seasonalRefresh!.refreshView
        view.frame = CGRectMake(0, 0, self.frame.size.width, heightOfSeasonalRefreshView)
        view.backgroundColor = UIColor.redColor()
        view.tag = seasonalRefreshViewTag
        self.addSubview(view)
    }
}