//
//  LCXRefreshHeader.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/9/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import UIKit
import MJRefresh

class LCXRefreshHeader: MJRefreshHeader {
    var loadingView: UIActivityIndicatorView?
    var refreshImage: UIImageView?
    
    override var state: MJRefreshState {
        didSet{
            switch state {
            case .idle:
                loadingView?.isHidden = true
                refreshImage?.isHidden = false
                loadingView?.stopAnimating()
            case .pulling:
                loadingView?.isHidden = false
                refreshImage?.isHidden = true
                loadingView?.startAnimating()
            case .refreshing:
                loadingView?.isHidden = false
                refreshImage?.isHidden = true
                loadingView?.startAnimating()
            default:
                break
            }
        }
    }
    
    override func prepare() {
        super.prepare()
        mj_h = 50
        
        loadingView = UIActivityIndicatorView(activityIndicatorStyle: .white)
        addSubview(self.loadingView!)
        refreshImage = UIImageView(image: UIImage(named: "ic_refresh")?.withRenderingMode(.alwaysTemplate))
        addSubview(refreshImage!)
    }
    
    
    override func placeSubviews(){
        super.placeSubviews()
        loadingView!.center = CGPoint(x: self.mj_w/2, y: self.mj_h/2)
        refreshImage!.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        refreshImage!.center = loadingView!.center
    }
    
}
