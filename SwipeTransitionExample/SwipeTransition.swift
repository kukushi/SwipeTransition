//
//  SwipeTransition.swift
//  SwipeTransitionExample
//
//  Created by kukushi on 2/18/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import UIKit

public class SwipeTransition: UIPercentDrivenInteractiveTransition {
    public var interacting = false
    
    private var shouldComplete = false
    private var navigationController: UINavigationController?
    private var gestureRecognizer: UIPanGestureRecognizer!
    
    // MARK
    
    public func intergate(viewController: UINavigationController) {
        navigationController = viewController
        prepareGestureRecognizer(viewController.view)
        
    }
    
    // MARK
    
    private func prepareGestureRecognizer(view: UIView) {
        gestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        gestureRecognizer.delegate = self
        if !contains(view.gestureRecognizers as! [UIGestureRecognizer], gestureRecognizer) {
            view.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    public func handlePan(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let translation = gestureRecognizer.translationInView(gestureRecognizer.view!)
        switch gestureRecognizer.state {
        case .Began:
            interacting = true
            navigationController?.popViewControllerAnimated(true)
            completionCurve = .EaseOut
            
        case .Changed:
            let screenWidth = UIScreen.mainScreen().bounds.width
            let fraction = min(max(translation.x / screenWidth, 0), 1)
            shouldComplete = fraction > 0.2
            updateInteractiveTransition(fraction)
            
        case .Ended, .Cancelled:
            interacting = false
            if !shouldComplete || gestureRecognizer.state == .Cancelled {
                cancelInteractiveTransition()
            }
            else {
                finishInteractiveTransition()
            }
        default:
            break
        }
    }
}

extension SwipeTransition: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count > 1
    }
}
