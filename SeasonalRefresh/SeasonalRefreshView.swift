//
//  SeasonalRefreshView.swift
//  SeasonalRefresh
//
//  Created by 田中賢治 on 2015/10/31.
//  Copyright © 2015年 田中賢治. All rights reserved.
//

import UIKit

let heightOfSeasonalRefreshView: CGFloat = 130

protocol SeasonalRefreshViewDelegate: class {
    func seasonalRefreshViewWillMoveToSuperView(newSuperView: UIView?)
}

class SeasonalRefreshView: UIView {
    weak var delegate: SeasonalRefreshViewDelegate?
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        delegate?.seasonalRefreshViewWillMoveToSuperView(newSuperview)
    }
}
