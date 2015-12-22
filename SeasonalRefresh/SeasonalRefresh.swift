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

enum SeasonalRefreshStage {
    case One, Two, Three, Four, Five, Six
}

private var KVOContext = "RefresherKVOContext"
private let ContentOffsetKeyPath = "contentOffset"

class SeasonalRefresh: NSObject, SeasonalRefreshViewDelegate {
    
    var season: Season = .Halloween
    
    weak var scrollView: UIScrollView?
    
    var refreshView: SeasonalRefreshView = SeasonalRefreshView()
    
    let maxStage = 6
    let numberOfUpStage: CGFloat = heightOfSeasonalRefreshView/6
    var stage: SeasonalRefreshStage = .One
    
    var action: (()->())?
    
    init(season: Season) {
        self.season = season
    }
    
    func startRefreshing() {
        action?()
    }
    
    func endRefreshing() {
        reset()
    }
    
    private func scrollViewDidScroll(scrollView: UIScrollView) {
        if let seasonalRefreshView = scrollView.viewWithTag(seasonalRefreshViewTag) {
            seasonalRefreshView.frame.origin.y = -heightOfSeasonalRefreshView
            
            let seasonalY = seasonalRefreshView.frame.origin.y
            // Multiplying minus to compare with numberOfUpStage.
            let offsetY = -scrollView.contentOffset.y
            
            if offsetY > 0 && offsetY < numberOfUpStage {
                stage = .One
            }
            if offsetY > numberOfUpStage && offsetY < numberOfUpStage*2 {
                stage = .Two
            }
            if offsetY > numberOfUpStage*2 && offsetY < numberOfUpStage*3 {
                stage = .Three
            }
            if offsetY > numberOfUpStage*3 && offsetY < numberOfUpStage*4 {
                stage = .Four
            }
            if offsetY > numberOfUpStage*4 && offsetY < numberOfUpStage*5 {
                stage = .Five
            }
            if offsetY > numberOfUpStage*5 {
                stage = .Six
            }
            
            switch stage {
            case .One:
                refreshView.backgroundColor = UIColor.lightGrayColor()
            case .Two:
                refreshView.backgroundColor = UIColor.darkGrayColor()
            case .Three:
                refreshView.backgroundColor = UIColor.blackColor()
            case .Four:
                refreshView.backgroundColor = UIColor.redColor()
            case .Five:
                refreshView.backgroundColor = UIColor.greenColor()
            case .Six:
                refreshView.backgroundColor = UIColor.blueColor()
            }
            
            if seasonalY + offsetY > 0 {
                startRefreshing()
            }
        }
    }
    
    private func reset() {
        UIView.animateWithDuration(0.3, animations: {
            self.scrollView?.contentOffset.y = 0
        })
        scrollView?.scrollEnabled = false
        scrollView?.scrollEnabled = true
        stage = .One
        refreshView.backgroundColor = UIColor.lightGrayColor()
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
