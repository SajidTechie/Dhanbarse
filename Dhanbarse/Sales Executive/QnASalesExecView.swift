//
//  QnASalesExecView.swift
//  Dhanbarse
//
//  Created by Goldmedal on 4/23/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import UIKit

class QnASalesExecView: BaseCustomView,UITableViewDelegate,UITableViewDataSource {

        @IBOutlet weak var salesExecProfileTableView: UITableView!
        @IBOutlet weak var searchBar: RoundSearchBar!
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var getSalesExecProfileElement : SalesApprovalData!
        var getSalesExecProfileObj = [SalesApprovalObj]()
        
        var deviceId = ""
        var userId = ""
        var mobileNo = ""
        var userCat = ""
        var token = ""
        var strSearchText = ""
        
        var getSalesExecProfileApi = ""

        var countSalesExecProfile = 0
        
        @IBOutlet weak var noDataView: NoDataView!
        
        override func xibSetup() {
            super.xibSetup()
            
            userCat = String(UserDefaults.standard.integer(forKey: "CategorySlNo"))
            deviceId = Utility.getDeviceId() ?? "-"
            mobileNo = UserDefaults.standard.string(forKey: "mobileNo") ?? ""
            userId = String(UserDefaults.standard.integer(forKey: "userId"))
            
            getSalesExecProfileApi = MyApi.PROD_BASE_URL + MyApi.SALES_EXEC_PROFILE_DETAIL
            
            // Do any additional setup after loading the view.
            if (Utility.isConnectedToNetwork()) {
                print("Internet connection available")
                self.apiSalesExecProfile()
                self.noDataView.hideView(view: self.noDataView)
            }
            else{
                print("No internet connection available")
                Utility.showMessage(title: "No Internet Connection", msg: "Make sure your device is connected to the internet.")
                self.noDataView.showView(view: self.noDataView, from: "NET")
            }
            
            salesExecProfileTableView.delegate = self
            salesExecProfileTableView.dataSource = self
        }
        
    
        
        // - -  - - - - - - API to get profile detail - - - - - - - - -
        func apiSalesExecProfile(){
          
            ViewControllerUtils.sharedInstance.showLoader()
            appDelegate.tokenCount = 0
            token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
            countSalesExecProfile += 1
            
            // - - -- - - call api here
            
    //        let json: [String: Any] = ["ApprovalCategoryId": 8,"UserCategory": userCat, "SearchString": strSearchText,"DeviceId": deviceId, "MobileNo": mobileNo, "OrganizationId": GlobalConstants.init().ORGANIZATION_ID, "UserId": userId]
            
            let json: [String: Any] = ["ApprovalUserProfileid": 8,
            "UserId": 6534,
            "UserCategory": 10,
            "MobileNo": "7666968400",
            "DeviceId": "d1234",
            "OrganizationId": 1]
            
            print("json sales exec profile - - -  ", json," - - - ",getSalesExecProfileApi)
            
            DataManager.shared.makeAPICall(url: getSalesExecProfileApi, params: json, method: .POST, token: token, success: { (response) in
                let data = response as? Data
                let isSearch = self.strSearchText.trimmingCharacters(in: NSCharacterSet.whitespaces).count  > 0
                
                DispatchQueue.main.async {
                    
                    do {
                        self.getSalesExecProfileElement = try JSONDecoder().decode(SalesApprovalData.self, from: data!)
                        var status = self.getSalesExecProfileElement.statusCode
                        
                        if(status == 200){
                            self.getSalesExecProfileObj = self.getSalesExecProfileElement.data ?? []
                            
                            if(self.getSalesExecProfileObj.count > 0)
                            {
                                self.salesExecProfileTableView.reloadData()
                            }
                         
                            print("sales exec profile detail - - - ",self.getSalesExecProfileObj,"----",self.getSalesExecProfileObj.count)
                            
                            ViewControllerUtils.sharedInstance.removeLoader()
                        }else{
                            var errMsg = self.getSalesExecProfileElement.errors?[0].errorMsg
                            Utility.showMessage(title: "Error", msg: errMsg ?? "")
                            ViewControllerUtils.sharedInstance.removeLoader()
                          
                            // - - - - -  Hit refresh access token - - - - - - -
                            if(status == 401){
                                print("Hit refresh token from Retailer Approval list")
                                
                                Utility.init().RefreshAccessToken(vc: self) { (error) in
                                    guard let error = error else {
                                        // - - - - success
                                        if(self.countSalesExecProfile < 3){
                                            self.apiSalesExecProfile()
                                        }else{
                                            Utility.showMessage(title: "Error", msg: "Retailer approval List Error")
                                        }
                                        return
                                    }
                                    print(error)
                                }
                                
                            }
                            
                            // - - - - -  Hit create access token - - - - - - -
                            if(status == 403){
                                
                                print("Hit create token from Retailer approval list")
                                Utility.init().CreateAccessToken(vc: self, callFrom: "") { (error) in
                                    guard let error = error else {
                                        // - - - - success
                                        if(self.countSalesExecProfile < 3){
                                            self.apiSalesExecProfile()
                                        }else{
                                            Utility.showMessage(title: "Error", msg: "Retailer approval List Error")
                                        }
                                        return
                                    }
                                    print(error)
                                }
                                
                            }
                        }
                        
                    }
                    catch let errorData {
                        Utility.showMessage(title: "Error", msg: "No Data Available")
                        ViewControllerUtils.sharedInstance.removeLoader()
                        self.noDataView.showView(view: self.noDataView, from: "NDA")
                        print(errorData.localizedDescription)
                    }
                    
                    
                    
                    if(self.getSalesExecProfileObj.count>0){
                        self.noDataView.hideView(view: self.noDataView)
                    }else{
                        self.noDataView.showView(view: self.noDataView, from: "NDA")
                    }
                    
                }
                
            }) { (Error) in
                Utility.showMessage(title: "Error", msg: "Server Error")
                ViewControllerUtils.sharedInstance.removeLoader()
                print(Error?.localizedDescription)
                self.noDataView.showView(view: self.noDataView, from: "ERR")
            }
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.getSalesExecProfileObj.count
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 430
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SalesExecProfileCell", for: indexPath) as! SalesExecProfileCell
            
            if(self.getSalesExecProfileObj.count > 0){
                var strAddress = "-"
                       strAddress = "Floor/Flat: \(self.getSalesExecProfileObj[indexPath.row].address1 ?? "-") \(self.getSalesExecProfileObj[indexPath.row].address2 ?? "-")\nCity: \(self.getSalesExecProfileObj[indexPath.row].city ?? "-")\nDistrict: \(self.getSalesExecProfileObj[indexPath.row].district ?? "-")\nState: \(self.getSalesExecProfileObj[indexPath.row].state ?? "-") \(self.getSalesExecProfileObj[indexPath.row].pin ?? "-")"
                
                cell.lblRetailerName.text = self.getSalesExecProfileObj[indexPath.row].name ?? "-"
                cell.lblRetailerPanNo.text = self.getSalesExecProfileObj[indexPath.row].panCard ?? "-"
                cell.lblRetailerStatus.text = self.getSalesExecProfileObj[indexPath.row].approvalStatus ?? "-"
                cell.lblRetailerAddress.text = strAddress
                cell.lblRetailerEmailId.text = self.getSalesExecProfileObj[indexPath.row].email ?? "-"
                cell.lblRetailerRegDate.text = self.getSalesExecProfileObj[indexPath.row].createdDate ?? "-"
                cell.lblRetailerCompanyName.text = self.getSalesExecProfileObj[indexPath.row].firmName ?? "-"
                cell.lblRetailerPhoneNumber.text = self.getSalesExecProfileObj[indexPath.row].mobile ?? "-"
            }
            
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            var slNo = 0
            var index = (indexPath.row ?? -1)
            print("Index - - - ",indexPath)
      
            
        }
    }
