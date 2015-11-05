//
//  RootViewController.swift
//  CleanUp
//
//  Created by Cameron Reilly on 11/4/15.
//  Copyright © 2015 Cameron Reilly. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDelegate {

    var pageViewController: UIPageViewController?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Configure the page view controller and add it as a child view controller.
        self.pageViewController = UIPageViewController(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController?.delegate = self
        
        guard let selfStory = self.storyboard else {
            return
        }
        guard let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: selfStory) else{
            return
        }
        let viewControllers = [startingViewController]
        self.pageViewController?.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })

        self.pageViewController?.dataSource = self.modelController
        
        guard let selfPageView = self.pageViewController else {
            return
        }
        self.addChildViewController(selfPageView)
        self.view.addSubview(selfPageView.view)

        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
        var pageViewRect = self.view.bounds
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0)
        }
        self.pageViewController?.view.frame = pageViewRect

        self.pageViewController?.didMoveToParentViewController(self)

    }

    var modelController: ModelController {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
        if _modelController == nil {
            _modelController = ModelController()
        }
        guard let mc = _modelController else{
            abort()
        }
        return mc
    }

    var _modelController: ModelController? = nil

    // MARK: - UIPageViewController delegate methods

    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        if (orientation == .Portrait) || (orientation == .PortraitUpsideDown) || (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
            // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to true, so set it to false here.
            guard let currentViewController = self.pageViewController?.viewControllers?[0] as? DataViewController else {
                abort()
            }
            let viewControllers = [currentViewController]
            self.pageViewController?.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })

            self.pageViewController?.doubleSided = false
            return .Min
        }

        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
        guard let currentViewController = self.pageViewController?.viewControllers?[0] as? DataViewController else {
            abort()
        }
        var viewControllers: [UIViewController]

        let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            guard let spvc = self.pageViewController else {
                abort()
            }
            let nextViewController = self.modelController.pageViewController(spvc, viewControllerAfterViewController: currentViewController)
            viewControllers = [currentViewController, nextViewController!]
        } else {
            guard let spvc = self.pageViewController else {
                abort()
            }
            let previousViewController = self.modelController.pageViewController(spvc, viewControllerBeforeViewController: currentViewController)
            viewControllers = [previousViewController!, currentViewController]
        }
        self.pageViewController?.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })

        return .Mid
    }


}

