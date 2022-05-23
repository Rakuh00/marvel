//
//  LoadingView.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit
import Lottie
import Motion

class LoadingView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var contentLottieView: UIView!
    
    var lottieAnimation: AnimationView?
    var backgroundColorView = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "LoadingView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        view.frame = bounds
        view.backgroundColor = backgroundColorView
        contentLottieView.backgroundColor = .clear
        view.alpha = 0
        setUpMotion()
        addSubview(view)
    }
    
    private func setUpMotion() {
        lottieAnimation?.motionIdentifier = "loading"
        view.motionIdentifier = "loadingView"
        contentLottieView.motionIdentifier = "loadingContentView"
    }
    
    func startLoading() {
        
        UIView.animate(withDuration: 0.20) {
            self.view.alpha = 1
        }
        lottieAnimation = AnimationView(name: "loading")
        lottieAnimation!.loopMode = .loop
        lottieAnimation!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        lottieAnimation!.contentMode = .scaleAspectFill
        lottieAnimation!.frame = contentLottieView.bounds
        contentLottieView.addSubview(lottieAnimation!)
        lottieAnimation!.loopMode = .loop
        lottieAnimation!.animationSpeed = 1.0
        lottieAnimation!.play(fromProgress: 0,
                              toProgress: 1,
                              completion: nil)
    }

    func stopLoading() {
        UIView.animate(withDuration: 0.20) {
            self.view.alpha = 0
        } completion: { (isCompletion) in
            self.lottieAnimation?.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
}
