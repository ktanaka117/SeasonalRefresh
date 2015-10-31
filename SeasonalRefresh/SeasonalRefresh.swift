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
    
    var season: Season = .Halloween
    
    weak var scrollView: UIScrollView?
    
    var refreshView: SeasonalRefreshView = SeasonalRefreshView()
    
    let maxStage = 6
    let numberOfUpStage: CGFloat = heightOfSeasonalRefreshView/6
    var stage = 1
    
    var action: (()->())?
    
    init(season: Season) {
        self.season = season
    }
    
    private func startRefreshing() {
        
    }
    
    private func endRefreshing() {
        
    }
    
    private func scrollViewDidScroll(scrollView: UIScrollView) {
        if let seasonalRefreshView = scrollView.viewWithTag(seasonalRefreshViewTag) {
            seasonalRefreshView.frame.origin.y = -heightOfSeasonalRefreshView
            
            let seasonalY = seasonalRefreshView.frame.origin.y
            let offsetY = scrollView.contentOffset.y
            
            if seasonalY - offsetY > seasonalY + numberOfUpStage && stage == 1 {
                print("Stage 1")
                stage++
            }
            if seasonalY - offsetY > seasonalY + numberOfUpStage*2 && stage == 2 {
                print("Stage 2")
                stage++
            }
            if seasonalY - offsetY > seasonalY + numberOfUpStage*3 && stage == 3 {
                print("Stage 3")
                stage++
            }
            if seasonalY - offsetY > seasonalY + numberOfUpStage*4 && stage == 4 {
                print("Stage 4")
                stage++
            }
            if seasonalY - offsetY > seasonalY + numberOfUpStage*5 && stage == 5 {
                print("Stage 5")
                stage++
            }
            if seasonalY - offsetY > seasonalY + numberOfUpStage*6 && stage == 6 {
                print("Stage 6")
                stage = 1
            }
            
            if seasonalY - offsetY > 0 {
                scrollView.contentOffset.y = 0
                scrollView.scrollEnabled = false
                scrollView.scrollEnabled = true
            }
            
            print(offsetY)
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
