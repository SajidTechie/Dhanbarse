//
//  SplashScreenController.swift
//  HrApp
//
//  Created by Goldmedal on 7/18/19.
//  Copyright © 2019 Goldmedal. All rights reserved.
//

import UIKit

class SplashScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onClick(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Intro", bundle: nil)
        let vcIntro = storyBoard.instantiateViewController(withIdentifier: "IntroScreenController") as! IntroScreenController
        self.navigationController!.pushViewController(vcIntro, animated: true)
    }

}
