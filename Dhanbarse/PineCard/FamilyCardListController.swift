//
//  FamilyCardListController.swift
//  Dhanbarse
//
//  Created by Goldmedal on 11/12/21.
//  Copyright © 2021 Goldmedal. All rights reserved.
//

import UIKit

class FamilyCardListController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var noDataView: NoDataView!
    @IBOutlet weak var tableView: UITableView!
     
    var getFamilyCardListElementMain : CardDetailListData!
    var getFamilyCardListObj = [CardDetailListMain]()
    
    var deviceId = ""
    var userId = ""
    var mobileNo = ""
    var userCat = ""
    var token = ""
    
    var getFamilyCardListApi = ""
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFamilyCardListApi = MyApi.BASE_URL_FAMILY_WALLET + MyApi.FAMILY_WALLET_CARD_LIST
          
        userCat = String(UserDefaults.standard.integer(forKey: "CategorySlNo"))
        deviceId = Utility.getDeviceId() ?? "-"
        mobileNo = UserDefaults.standard.string(forKey: "mobileNo") ?? ""
        userId = String(UserDefaults.standard.integer(forKey: "userId"))
    
        // Do any additional setup after loading the view.
        if (Utility.isConnectedToNetwork()) {
            print("Internet connection available")
            self.apiFamilyCardList()
            self.noDataView.hideView(view: self.noDataView)
        }
        else {
            print("No internet connection available")
            Utility.showMessage(title: "No Internet Connection", msg: "Make sure your device is connected to the internet.")
            self.noDataView.showView(view: self.noDataView, from: "NET")
        }
        
        addBackMenuButton()
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    
    
    
    // - - - - -  API to show FamilyCard list - - - - -
    func apiFamilyCardList(){
        
        ViewControllerUtils.sharedInstance.showLoader()

        token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
         
        // - - -- - - call api here
        
        let json: [String: Any] = ["UserId": userId,
                                   "UserCategory": userCat,
                                   "MobileNo": mobileNo,
                                   "DeviceId": deviceId,
                                   "OrganizationId": GlobalConstants.init().ORGANIZATION_ID]
        
        print("API FamilyCard list json - - -  ", json," - - - ",getFamilyCardListApi)
        
        DataManager.shared.makeAPICall(url: getFamilyCardListApi, params: json, method: .POST, token: token, success: { (response) in
            let data = response as? Data
            
            DispatchQueue.main.async {
                
                do {
                    self.getFamilyCardListElementMain = try JSONDecoder().decode(CardDetailListData.self, from: data!)
                    
                    let status = self.getFamilyCardListElementMain.statusCode
                    
                    if(status == 200){
                        self.getFamilyCardListObj = self.getFamilyCardListElementMain.data ?? []
                        print("FamilyCard list details - - - ",self.getFamilyCardListObj)
                        ViewControllerUtils.sharedInstance.removeLoader()
                  
                    }else{
                        let errMsg = self.getFamilyCardListElementMain.errors?[0].errorMsg
                        Utility.showMessage(title: "Error", msg: errMsg ?? "")
                        ViewControllerUtils.sharedInstance.removeLoader()
                    }
                    
                }
                catch let errorData {
                    Utility.showMessage(title: "Error", msg: "No Data available")
                    ViewControllerUtils.sharedInstance.removeLoader()
                    print(errorData.localizedDescription)
                }
                
                
                if(self.tableView != nil)
                {
                    self.tableView.reloadData()
                }
                
                if(self.getFamilyCardListObj.count>0){
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
    
    
    @IBAction func clicked_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getFamilyCardListObj.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyCardCell", for: indexPath) as! FamilyCardCell
        
     
        cell.lblCardName.text = self.getFamilyCardListObj[indexPath.row].CardHolderFirstName ?? ""
        
        cell.btnManage.addTarget(self, action: #selector(self.clicked_Manage(sender:)), for: .touchUpInside)
        cell.btnManage.tag = indexPath.row
          
        return cell
        
    }
  
    
    @objc func clicked_Manage(sender: UIButton){
        var index = sender.tag
        //userAccountID = self.getFamilyCardListObj[index].userAccountID ?? -1
//        if(userAccountID == -1){
//            Utility.showMessage(title: "Invalid", msg: "Account is not valid")
//        }else{
//            if (Utility.isConnectedToNetwork()) {
//                print("Internet connection available")
//                self.apiRemovePayoutAccount()
//            }
//            else {
//                print("No internet connection available")
//                Utility.showMessage(title: "No Internet Connection", msg: "Make sure your device is connected to the internet.")
//
//            }
//        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "PaytmCashback", bundle: nil)
        let vcAddAccount = storyBoard.instantiateViewController(withIdentifier: "CardDetailController") as! CardDetailController
        self.navigationController!.pushViewController(vcAddAccount, animated: false)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var slNo = 0
        var index = (indexPath.row ?? -1)
        print("Index - - - ",indexPath)
        
    
    }

}
