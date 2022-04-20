//
//  IntroScreenController.swift
//  HrApp
//
//  Created by Goldmedal on 7/18/19.
//  Copyright © 2019 Goldmedal. All rights reserved.
//

import UIKit

class IntroScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClick(_ sender: UIButton) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
//        let vcLogin = storyBoard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
//        self.navigationController!.pushViewController(vcLogin, animated: true)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vcHome = storyBoard.instantiateViewController(withIdentifier: "Dashboard") as! DashboardController
        self.navigationController!.pushViewController(vcHome, animated: true)
    }

}
