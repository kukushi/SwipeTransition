//
//  SwipeTransitionDelegate.swift
//  SwipeTransitionExample
//
//  Created by kukushi on 2/19/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import UIKit

class SwipeTransitionDeleagte: NSObject, UINavigationControllerDelegate {
    var transitionController = SwipeTransition()
    var transitionAnimator = SwipeTransitionAnimator()
    
    // used to pass the delegate
    var delegate: UINavigationControllerDelegate?
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .Push:
            transitionController.intergate(navigationController)
            return nil
        default:
            return transitionAnimator
        }
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return transitionController.interacting ? transitionController : nil
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        delegate?.navigationController?(navigationController, willShowViewController: viewController, animated: animated)
    }
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        delegate?.navigationController?(navigationController, didShowViewController: viewController, animated: animated)
    }
    
    func navigationControllerSupportedInterfaceOrientations(navigationController: UINavigationController) -> Int {
        return delegate?.navigationControllerSupportedInterfaceOrientations?(navigationController) ?? 0
    }
    
    func navigationControllerPreferredInterfaceOrientationForPresentation(navigationController: UINavigationController) -> UIInterfaceOrientation {
        return delegate?.navigationControllerPreferredInterfaceOrientationForPresentation?(navigationController) ?? .Portrait
    }
}
