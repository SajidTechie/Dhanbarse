//
//  UpdateInsuranceViewController.swift
//  Dhanbarse
//
//  Created by Goldmedal on 7/27/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import UIKit

class UpdateInsuranceViewController: UIViewController,CommonDelegate {
    
    @IBOutlet weak var imvClose: UIImageView!
    
    @IBOutlet weak var edtName: UITextField!
    @IBOutlet weak var edtPanNo: UITextField!
    @IBOutlet weak var edtMaritalStatus: UITextField!
    @IBOutlet weak var edtNominee: UITextField!
    @IBOutlet weak var edtRelationship: UITextField!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var vwDOB: UIView!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    
    var dateFormatter = DateFormatter()
    var dobDate: Date?
    var strDOB = ""
    var strUsername = ""
    var strGender = "Male"
    var strPanNo = ""
    var strNomineeName = ""
    var strRelationship = ""
    var strMaritalStatus = ""
    
    var token = ""
    var deviceId = String()
    var userId = String()
    var mobileNo = String()
    var userCat = String()
    var slNo = Int()
    
    var updateInsuranceMain : CommonMessageData!
    var updateInsuranceObj = [CommonMessageObj]()
    
    var updateInsuranceApi = ""
    
    var delegate:CommonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let tabClose = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        imvClose.addGestureRecognizer(tabClose)
        
        let gestureDate = UITapGestureRecognizer(target: self, action: "clickDate:")
        vwDOB.addGestureRecognizer(gestureDate)
        
        updateInsuranceApi = MyApi.PROD_BASE_URL + MyApi.UPDATE_INSURANCE
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
        dismiss(animated: true)
    }
    
    @IBAction func clicked_male(_ sender: UIButton) {
           if(!btnMale.isSelected)
           {
               btnMale.isSelected = true
               btnFemale.isSelected = false
           }
       }
       
       @IBAction func clicked_female(_ sender: UIButton) {
           if(!btnFemale.isSelected)
           {
               btnFemale.isSelected = true
               btnMale.isSelected = false
           }
           
       }
    
    @IBAction func clicked_update(_ sender: UIButton) {
        // - - - Hit API to update insurance detail
       
        strUsername = edtName.text ?? ""
        strPanNo = edtPanNo.text ?? ""
        strMaritalStatus = edtMaritalStatus.text ?? ""
        strNomineeName = edtNominee.text ?? ""
        strRelationship = edtRelationship.text ?? ""
        
        if(strUsername.isEmpty){
            Utility.showMessage(title: "Invalid UserName", msg: "Please enter valid Username")
        }else if(strDOB.isEmpty){
            Utility.showMessage(title: "Invalid DOB", msg: "Please select valid DOB")
        }else if(!(Utility.init().validatePANCardNumber(strPanNo))){
            Utility.showMessage(title: "Invalid PAN No", msg: "Pan Card No is not correct")
        }else if(strMaritalStatus.isEmpty){
            Utility.showMessage(title: "Invalid Marital Status", msg: "Please enter valid Marital Status")
        }else if(strNomineeName.isEmpty){
            Utility.showMessage(title: "Invalid Nominee Name", msg: "Please enter valid Nominee Name")
        }else if(strRelationship.isEmpty){
            Utility.showMessage(title: "Invalid Relationship", msg: "Please enter valid Relationship with Nominee")
        }else{
            // - - - - Hit API to update Insurance details - - - - -  -
            if (Utility.isConnectedToNetwork()) {
                print("Internet connection available")
                self.apiUpdateInsurance()
            }
            else{
                Utility.showMessage(title: "No Internet Connection", msg: "Make sure your device is connected to the internet.")
                print("No internet connection available")
            }
        }
    }
    
    
    // - - - -  - API to update insurance -  - - - - - - -
    func apiUpdateInsurance(){
        ViewControllerUtils.sharedInstance.showLoader()
        
        token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        
        // - - - - - - call api here
        let json: [String: Any] =   ["SlNo": slNo,
                                     "UserNameAsPerPanCard": strUsername,
                                     "DateOfBirth": strDOB,
                                     "PanCardNo": strPanNo,
                                     "Gender": btnMale.isSelected ? "Male" : "Female",
                                     "MaritalStatus": strMaritalStatus,
                                     "NameOfNominee": strNomineeName,
                                     "Relationship":strRelationship,
                                     "UserId": userId,
                                     "UserCategory": userCat,
                                     "MobileNo": mobileNo,
                                     "DeviceId": deviceId,
                                     "OrganizationId": GlobalConstants.init().ORGANIZATION_ID]
        
        
        print("apiUpdateInsurance json - - - ", json," - - - - ",updateInsuranceApi)
        
        DataManager.shared.makeAPICall(url: updateInsuranceApi, params: json, method: .POST, token: token, success: { (response) in
            let data = response as? Data
            
            DispatchQueue.main.async {
                
                do {
                    self.updateInsuranceMain = try JSONDecoder().decode(CommonMessageData.self, from: data!)
                    print("Update Insurance- - - ", self.updateInsuranceMain)
                    
                    var status = self.updateInsuranceMain.statusCode
                    
                    if(status == 200){
                        ViewControllerUtils.sharedInstance.removeLoader()
                        Utility.showMessage(title: "Success", msg: self.updateInsuranceMain.statusCodeMessage ?? "")
                        
                        self.delegate?.refreshApi()
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        var errMsg = self.updateInsuranceMain.errors?[0].errorMsg
                        Utility.showMessage(title: "Error", msg: errMsg ?? "")
                        ViewControllerUtils.sharedInstance.removeLoader()
                    }
                    
                }
                catch let errorData {
                    Utility.showMessage(title: "Error", msg: "No Data Available")
                    ViewControllerUtils.sharedInstance.removeLoader()
                    print(errorData.localizedDescription)
                }
                
            }
            
        }) { (Error) in
            Utility.showMessage(title: "Error", msg: "Server Error")
            ViewControllerUtils.sharedInstance.removeLoader()
            print(Error?.localizedDescription)
        }
    }
    
    
    func updateDate(value: String, date: Date) {
        strDOB = Utility.formattedDateFromString(dateString: value, withFormat: "yyyy-MM-dd")!
        lblDOB.text = strDOB
    }
    
    
    @objc func clickDate(_ sender:UITapGestureRecognizer){
        let sb = UIStoryboard(name: "DatePicker", bundle: nil)
        
        let popup = sb.instantiateInitialViewController()  as? DatePickerController
        popup?.callFrom = "DOB"
        
        let currDate = Date()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        var strFromDate = dateFormatter.string(from: Calendar.current.date(byAdding: .year, value: -18, to: currDate)!)
        var fromDate = dateFormatter.date(from: strFromDate)
        popup?.fromDate = fromDate
        
        popup?.delegate = self
        self.present(popup!, animated: true)
    }
    
}
