//
//  ForgotPasswordController.swift
//  HrApp
//
//  Created by Goldmedal on 7/18/19.
//  Copyright © 2019 Goldmedal. All rights reserved.
//

import UIKit

class ForgotPasswordController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClick(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        let vcOtp = storyBoard.instantiateViewController(withIdentifier: "OtpController") as! OtpController
        self.navigationController!.pushViewController(vcOtp, animated: true)
    }

}
