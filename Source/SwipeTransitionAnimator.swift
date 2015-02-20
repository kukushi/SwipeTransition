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
    var tabBarIndex: Int?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let containerView = transitionContext.containerView()
        // from view is the pushed view in the pop case
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        
        let initialFrame = transitionContext.initialFrameForViewController(toVC)
        let finialFrame = transitionContext.finalFrameForViewController(toVC)
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        
        // animate fromView x from 0 to screen width
        var fromViewInitialFrame = transitionContext.initialFrameForViewController(fromVC)
        var fromViewFinialFrame = fromViewInitialFrame
        fromViewFinialFrame.origin.x = screenWidth
        
        // animate toView from -1/4 screen width to 0
        toView.frame.origin.x = -fromView.frame.width * 0.25
        
        fromViewInitialFrame.origin.x = 0
        fromView.frame = fromViewInitialFrame
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        // animate tab bar if neccessary
        let tabBar = fromVC.tabBarController?.tabBar
        tabBar?.frame.origin.x = toView.frame.origin.x
        tabBar?.hidden = false
        
        let originalSuperView = fromVC.tabBarController?.tabBar.superview
        
        if tabBar != nil {
            // in order to interactive animate tab bar, add tab bar as the container view's
            // subview
            tabBarIndex = find(originalSuperView?.subviews as! [UIView], tabBar!)
            containerView.insertSubview(tabBar!, aboveSubview: toView)
        }
        
        addShadowLayerTo(fromView)
        
        UIView.animateWithDuration(animationDuration, delay: 0, options: .CurveLinear, animations: { () -> Void in
            fromView.frame = fromViewFinialFrame
            toView.frame.origin.x = 0
            tabBar?.frame.origin.x = 0
            
            }) { (finish) -> Void in
                if tabBar != nil {
                    tabBar?.removeFromSuperview()
                    originalSuperView?.insertSubview(tabBar!, atIndex: self.tabBarIndex!)
                }
                
                if transitionContext.transitionWasCancelled() {
                    transitionContext.completeTransition(false)
                    tabBar?.hidden = true
                }
                else {
                    transitionContext.completeTransition(true)
                }
        }
    }
    
    func addShadowLayerTo(view: UIView) {
        let shadowRect = CGRectMake(-3, 0, 6, view.frame.height)
        let shadowBezier = UIBezierPath(rect: shadowRect)
        view.layer.shadowPath = shadowBezier.CGPath
        view.layer.shadowOpacity = 0.2
        
        let shadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        shadowAnimation.fromValue = view.layer.shadowOpacity
        shadowAnimation.toValue = 0
        shadowAnimation.duration = animationDuration
        
        view.layer.addAnimation(shadowAnimation, forKey: "opacityChange")
        view.layer.shadowOpacity = 0
    }
    
    func animationEnded(transitionCompleted: Bool) {
        
    }
}
