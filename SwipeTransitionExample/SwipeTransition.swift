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
    private var presentingVC: UIViewController?
    private var shouldComplete = false
    
    override public var completionSpeed: CGFloat {
        get {
            return 1 - percentComplete
        }
        set {
            
        }
    }
    
    func wireTo(viewController: UIViewController) {
        presentingVC = viewController
        prepareGestureRecognizer(viewController.view)
        
    }
    
    func prepareGestureRecognizer(view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        view.addGestureRecognizer(gesture)
    }
    
    func handlePan(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let translation = gestureRecognizer.translationInView(gestureRecognizer.view!)
        switch gestureRecognizer.state {
        case .Began:
            interacting = true
            if let navigationController = presentingVC as? UINavigationController {
                navigationController.popViewControllerAnimated(true)
                completionCurve = .EaseOut
            }
            
        case .Changed:
            let fraction = min(max(translation.x / 400, 0), 1)
            shouldComplete = fraction > 0.5
            updateInteractiveTransition(fraction)
            println(fraction)
            
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
