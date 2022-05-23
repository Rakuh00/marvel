//
//  ConstructorLoading.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit

public class ConstructorLoading {

    var viewLoading: LoadingView!
    
    init(frame: CGRect) {
        self.viewLoading = LoadingView(frame: frame)
    }

    public func showLoading(originViewController: UIViewController) {
        originViewController.view.addSubview(viewLoading)
        viewLoading.startLoading()
    }
    
    public func stopLoading() {
        viewLoading.stopLoading()
    }
}
