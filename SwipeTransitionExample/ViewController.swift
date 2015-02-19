//
//  ViewController.swift
//  SwipeTransitionExample
//
//  Created by kukushi on 2/18/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var transitionDelegate = SwipeTransitionDeleagte()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.delegate = transitionDelegate
        navigationController?.interactivePopGestureRecognizer.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PushYo" {
           let viewController =  segue.destinationViewController as! UIViewController
            
                viewController.hidesBottomBarWhenPushed = true
        }
    }
}

