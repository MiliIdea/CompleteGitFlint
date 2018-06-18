//
//  TooLateViewController.swift
//  Flint
//
//  Created by MILAD on 4/25/18.
//  Copyright © 2018 MILAD. All rights reserved.
//

import UIKit

class TooLateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        
        for controller in (self.parent!.navigationController!.viewControllers as Array) {
            if controller.isKind(of: FirstMapViewController.self) {
                self.parent!.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
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
