//
//  SidePanelViewController.swift
//  LazyB
//
//  Created by Marc Löffler on 04.06.17.
//  Copyright © 2017 Marc Löffler. All rights reserved.
//

import UIKit

protocol SidePanelViewControllerDelegate {
    // func animalSelected(animal: Animal)
}

class SidePanelViewController: UIViewController {
    
    var delegate: SidePanelViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
