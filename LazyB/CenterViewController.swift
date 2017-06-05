//
//  CenterViewController.swift
//  LazyB
//
//  Created by Marc Löffler on 04.06.17.
//  Copyright © 2017 Marc Löffler. All rights reserved.
//

import UIKit
import MapKit

protocol CenterViewControllerDelegate {
    func toggleLeftPanel()
    // func toggleRightPanel()
    func collapseSidePanels()
    
    func addLeftPanelViewController()
    // func addRightPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
    // func animateRightPanel(shouldExpand: Bool)
}

class CenterViewController: UIViewController, SidePanelViewControllerDelegate {
    
    var delegate: CenterViewControllerDelegate?
    
    var sidePanelButton: HamburgerButton!
    
    // @IBOutlet weak var sidePanelButton: UIBarButtonItem!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /* let bar:UINavigationBar! =  self.navigationController?.navigationBar
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        visualEffectView.frame =  (self.navigationController?.navigationBar.bounds.insetBy(dx: 0, dy: -10).offsetBy(dx: 0, dy: -10))!
        bar.isTranslucent = true
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.addSubview(visualEffectView) */
        
        // let btnShowMenu = HamburgerButton()
        // btnShowMenu.addTarget(self, action: #selector(self.onSlideMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        // btnShowMenu.addTarget(self, action: #selector(self.onSlideMenuButtonPressed(_:)), for: .touchUpInside)
        sidePanelButton = HamburgerButton()
        sidePanelButton.frame = CGRect(x: 0, y: 0, width: 18, height: 16)
        sidePanelButton.addTarget(self, action:#selector(self.onSlideMenuButtonPressed(_:)), for: .touchUpInside)
        // sidePanelButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        let customBarItem = UIBarButtonItem(customView: sidePanelButton)
        self.navigationItem.leftBarButtonItem = customBarItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Actions
    
    func onSlideMenuButtonPressed(_ sender : UIButton) {
        print("onSlideMenuButtonPressed")
        delegate?.toggleLeftPanel()
        self.sidePanelButton.showsMenu = !self.sidePanelButton
            .showsMenu
    }
    
    /* @IBAction func toggleSidePanel(_ sender: Any) {
        delegate?.toggleLeftPanel()
    } */
    

}
