//
//  ContainerViewController.swift
//  LazyB
//
//  Created by Marc Löffler on 04.06.17.
//  Copyright © 2017 Marc Löffler. All rights reserved.
//

import UIKit

enum SlideOutState {
    case BothCollapsed
    case LeftPanelExpanded
    case RightPanelExpanded
}

class ContainerViewController: UIViewController, CenterViewControllerDelegate {
    
    var centerNavigationController: UINavigationController!
    var centerViewController: CenterViewController!
    
    var currentState: SlideOutState = .BothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .BothCollapsed
            showShadowForCenterViewController(shouldShowShadow: shouldShowShadow)
        }
    }
    
    var leftViewController: SidePanelViewController?
    // var rightViewController: SidePanelViewController?
    
    let centerPanelExpandedOffset: CGFloat = 700

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // centerViewController = UIStoryboard.centerViewController()
        centerViewController = CenterViewController.instance()
        centerViewController.delegate = self
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        // centerViewController.title = "Hallo"
        
        // centerNavigationController.didMoveToParentViewController(self)
        centerNavigationController.didMove(toParentViewController: self)
        
        
        self.navigationBlurEffect()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // return .lightContent
        return .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let statusView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 20))
        // statusView.backgroundColor = UIColor.black
        statusView.backgroundColor = UIColor.clear
        self.view.addSubview(statusView)
        // self.view.sendSubview(toBack: statusView)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Blur effect for NavigationBar
    
    /* func navigationBlurEffect() {
        // Add blur view
        let bounds = centerNavigationController.navigationBar.bounds as CGRect!
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        visualEffectView.frame = bounds!
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //here you can choose one
        centerNavigationController.navigationBar.addSubview(visualEffectView)
        // Or
        /*
         If you find that after adding blur effect on navigationBar, navigation buttons are not visible then add below line after adding blurView code.
         */
        centerNavigationController.navigationBar.sendSubview(toBack: visualEffectView)
        
        // Here you can add visual effects to any UIView control.
        // Replace custom view with navigation bar in above code to add effects to custom view.
    } */
    
    func navigationBlurEffect() {
        let bar:UINavigationBar! =  self.centerNavigationController.navigationBar
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        visualEffectView.frame =  (bar.bounds.insetBy(dx: 0, dy: -10).offsetBy(dx: 0, dy: -10))
        bar.isTranslucent = true
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.addSubview(visualEffectView)
        bar.sendSubview(toBack: visualEffectView)
    }
    
    // MARK: Delegate Functions
    
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    
    
    func collapseSidePanels() {
        switch (currentState) {
        case .LeftPanelExpanded:
            toggleLeftPanel()
        default:
            break
        }
    }
    
    
    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            // leftViewController = UIStoryboard.leftViewController()
            leftViewController = SidePanelViewController.instance()
            // leftViewController!.animals = Animal.allCats()
            
            addChildSidePanelController(sidePanelController: leftViewController!)
        }
    }
    
    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
        sidePanelController.delegate = centerViewController
        
        view.insertSubview(sidePanelController.view, at: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
 
    
    func animateLeftPanel(shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .LeftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: centerNavigationController.view.frame.width - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .BothCollapsed
                
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil;
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
        
    }
    
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    

}


extension UIViewController {
    class func instance() -> Self {
        print(self)
        var storyboardName = String(describing: self)
        
        if let range = storyboardName.range(of: "Controller") {
            storyboardName.removeSubrange(range)
        }
        print(storyboardName)
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.initialViewController()
    }
}

extension UIStoryboard {
    func initialViewController<T: UIViewController>() -> T {
        return self.instantiateInitialViewController() as! T
    }
}


/* private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func leftViewController() -> SidePanelViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("LeftViewController") as? SidePanelViewController
    }
    
    class func rightViewController() -> SidePanelViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("RightViewController") as? SidePanelViewController
    }
    
    class func centerViewController() -> CenterViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("CenterViewController") as? CenterViewController
    }
    
} */
