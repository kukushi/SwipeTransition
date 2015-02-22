# SwipeTransition

Pop transition like `UINavigationController`'s `interactivePopGestureRecognizer` which work in the whole screen.

## Usage

	var transitionDelegate = SwipeTransitionDeleagte()

	    override func viewDidLoad() {
	        super.viewDidLoad()
        
	        navigationController?.delegate = transitionDelegate
	        navigationController?.interactivePopGestureRecognizer.enabled = false
	    }

## Install

Drag the source file into your project.

## Requirement

* iOS 7.0 or later
* Xcode 6.3 or later (Swift 1.2)

## Todo

* Carthage & Cocoapods support (after Xcode 6.3 release).

## License

This code is distributed under the terms and conditions of the MIT license.


