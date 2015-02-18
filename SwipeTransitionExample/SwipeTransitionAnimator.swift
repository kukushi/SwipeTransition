//
//  SwipeTransitionAnimator.swift
//  SwipeTransitionExample
//
//  Created by kukushi on 2/18/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import UIKit

class SwipeTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let animationDuration = 0.4
    var context: UIViewControllerContextTransitioning?
    
    var fromVC: UIViewController {
        return context!.viewControllerForKey(UITransitionContextFromViewControllerKey)!
    }
    
    var toView: UIView {
        return context!.viewForKey(UITransitionContextToViewKey)!
    }
    
    var fromView: UIView {
        return context!.viewForKey(UITransitionContextFromViewKey)!
    }
    
    var containerView: UIView {
        return context!.containerView()
    }
    
    var toViewInitialFrame: CGRect {
        let toVC = context!.viewControllerForKey(UITransitionContextToViewControllerKey)!
        return context!.initialFrameForViewController(toVC)
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        context = transitionContext
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let fromView = fromVC.view
        
        let initialFrame = transitionContext.initialFrameForViewController(toVC)
        let finialFrame = transitionContext.finalFrameForViewController(toVC)
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        
        var toViewInitialFrame = finialFrame
        toViewInitialFrame.origin.x -= screenWidth
        toView.frame = toViewInitialFrame
        
        fromVC.tabBarController?.tabBar.hidden = false
        
        transitionContext.containerView().insertSubview(toView, aboveSubview: fromView)
        
        UIView.animateWithDuration(animationDuration, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.toView.frame = finialFrame
            }) { (finish) -> Void in
                if transitionContext.transitionWasCancelled() {
                    transitionContext.completeTransition(false)
//                    containerView.addSubview(self.toView)
                }
                else {
                    transitionContext.completeTransition(true)
//                    containerView.addSubview(self.toView)
                }
        }
    }
    
    func animationEnded(transitionCompleted: Bool) {
        let canceled = context!.transitionWasCancelled()
//        if canceled {
//            toView.frame = toViewInitialFrame
//            toView.removeFromSuperview()
//            
//            containerView.addSubview(fromView)
//            fromView.frame = context!.initialFrameForViewController(fromVC)
//        }
    }
}
