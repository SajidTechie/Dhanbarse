//
//  CounterBoyAmountTransferController.swift
//  Dhanbarse
//
//  Created by Goldmedal on 20/03/21.
//  Copyright © 2021 Goldmedal. All rights reserved.
//
import DropDown
import UIKit

class CounterBoySchemeController: UIViewController,UITableViewDelegate,UITableViewDataSource, CommonDelegate  {
    
    @IBOutlet weak var tblAmountTransfer: IntrinsicTableView!
    @IBOutlet weak var noDataView: NoDataView!
  
    @IBOutlet weak var lblRRP: UILabel!
    @IBOutlet weak var lblTransferrableAmnt: UILabel!
    @IBOutlet weak var lblVoidAmnt: UILabel!
    @IBOutlet weak var lblTotalTransferrableAmnt: UILabel!
    @IBOutlet weak var lblTotalVoidAmnt: UILabel!
    @IBOutlet weak var edtDescription: UITextField!
    
    @IBOutlet weak var vwSchemeType: UIView!
    @IBOutlet weak var vwTransferType: UIView!
    @IBOutlet weak var lblSchemeType: UILabel!
    @IBOutlet weak var lblTransferType: UILabel!
    
    @IBOutlet weak var btnFromDate: UIButton!
    @IBOutlet weak var btnToDate: UIButton!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var dateFormatter = DateFormatter()
    var fromDate: Date?
    var toDate: Date?
    var strFromDate = ""
    var strToDate = ""
    
    var intSchemeType = -1
    var intTransferType = -1
    
    var delegate:CommonDelegate?
    
    var getSchemeListElementMain : SchemeListElement!
    var getSchemeListArr = [SchemeListData]()
    
    var getCBAmountTransferElementMain : CBAmountTransferElement!
    var getCBAmountTransferArr = [CBAmountTransferData]()
    
    var CBAmountTransferUpdateElementMain : CommonUpdateData!
    var CBAmountTransferUpdateData = [CommonUpdateObj]()
    
    var deviceId = ""
    var userId = ""
    var mobileNo = ""
    var userCat = ""
    var token = ""
    
    var schemeListApi = ""
    var cbAmountTransferListApi = ""
    var cbAmountTransferUpdateApi = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        schemeListApi = MyApi.PROD_BASE_URL + MyApi.COUNTERBOY_SCHEME_LIST
        cbAmountTransferListApi = MyApi.PROD_BASE_URL + MyApi.COUNTERBOY_AMOUNT_TRANSFER_DETAIL
        cbAmountTransferUpdateApi = MyApi.PROD_BASE_URL + MyApi.COUNTERBOY_CASHBACK_AMOUNT_TRANSFER
        
        let gestureSchemeType = UITapGestureRecognizer(target: self, action: Selector("clickSchemeType:"))
        vwSchemeType.addGestureRecognizer(gestureSchemeType)
        
        let gestureTransferType = UITapGestureRecognizer(target: self, action: Selector("clickTransferType:"))
        vwTransferType.addGestureRecognizer(gestureTransferType)
        
        userCat = String(UserDefaults.standard.integer(forKey: "CategorySlNo"))
        deviceId = Utility.getDeviceId() ?? "-"
        mobileNo = UserDefaults.standard.string(forKey: "mobileNo") ?? ""
        userId = String(UserDefaults.standard.integer(forKey: "userId"))
        
        
        let currDate = Date()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        strToDate = dateFormatter.string(from: currDate)
        strFromDate = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -30, to: currDate)!)
        
        fromDate = dateFormatter.date(from: strFromDate)
        toDate = dateFormatter.date(from: strToDate)
        
        btnFromDate.setTitle(strFromDate, for: .normal)
        btnToDate.setTitle(strToDate, for: .normal)
        
        strFromDate = Utility.formattedDateFromString(dateString: strFromDate, withFormat: "MM/dd/yyyy")!
        strToDate = Utility.formattedDateFromString(dateString: strToDate, withFormat: "MM/dd/yyyy")!
        
        // Do any additional setup after loading the view.
        if (Utility.isConnectedToNetwork()) {
            print("Internet connection available")
            self.apiCounterBoySchemeListData()
            self.noDataView.hideView(view: self.noDataView)
        }
        else{
            print("No internet connection available")
            Utility.showMessage(title: "No Internet Connection", msg: "Make sure your device is connected to the internet.")
            self.noDataView.showView(view: self.noDataView, from: "NET")
        }
        
        self.tblAmountTransfer.delegate = self;
        self.tblAmountTransfer.dataSource = self;
    }
    
    
    // - - -  - - - - - - API to get list of scheme for counter boy  - - - - -- - - -
    func apiCounterBoySchemeListData(){

        let json: [String: Any] = ["UserId": userId,
                                   "UserCategory": userCat,
                                   "MobileNo": mobileNo,
                                   "DeviceId": deviceId,
                                   "OrganizationId": GlobalConstants.init().ORGANIZATION_ID]
        
        print("counter boy scheme list - - -  ", json," - - - ",schemeListApi)
        
        DataManager.shared.makeAPICall(url: schemeListApi, params: json, method: .POST, token: "-", success: { (response) in
            let data = response as? Data
            
            DispatchQueue.main.async {
                
                do {
                    self.getSchemeListElementMain = try JSONDecoder().decode(SchemeListElement.self, from: data!)
                    
                    let status = self.getSchemeListElementMain.statusCode
                
                    if(status == 200){
                        self.getSchemeListArr = self.getSchemeListElementMain.data ?? []
                    }
                   
                }
                catch let errorData {
                    print(errorData.localizedDescription)
                }
            }
            
        }) { (Error) in
            print(Error?.localizedDescription)
        }
    }
    
    
    // - -  - - - - - - API to get counter boy amount transfer detail - - - - - - - - -
    func apiCBAmountTransferDetail(){
        ViewControllerUtils.sharedInstance.showLoader()
        
        // - - -- - - call api here
        let json: [String: Any] = ["FromDate": strFromDate,
                                   "ToDate": strToDate,
                                   "UserId": userId,
                                   "UserCategory": userCat,
                                   "MobileNo": mobileNo,
                                   "DeviceId": deviceId,
                                   "OrganizationId": GlobalConstants.init().ORGANIZATION_ID]
        
        print("json amount transfer detail list - - -  ", json," - - - ",cbAmountTransferListApi)
        
        DataManager.shared.makeAPICall(url: cbAmountTransferListApi, params: json, method: .POST, token: "-", success: { (response) in
            let data = response as? Data
            
            DispatchQueue.main.async {
                
                do {
                    self.getCBAmountTransferElementMain = try JSONDecoder().decode(CBAmountTransferElement.self, from: data!)
                    
                    let status = self.getCBAmountTransferElementMain.statusCode
                    
                    print("Amount transfer detail - - -  - - ",self.getCBAmountTransferElementMain)
                    
                    if(status == 200){
                        self.getCBAmountTransferArr = self.getCBAmountTransferElementMain.data ?? []
                      
                        ViewControllerUtils.sharedInstance.removeLoader()
                        
                        self.noDataView.hideView(view: self.noDataView)
                     
                    }else{
                        ViewControllerUtils.sharedInstance.removeLoader()
                        self.noDataView.showView(view: self.noDataView, from: "NDA")
                    }
                    
                    if(self.tblAmountTransfer != nil)
                    {
                        self.tblAmountTransfer.reloadData()
                    }
                    
                    if(self.getCBAmountTransferArr.count>0){
                        self.noDataView.hideView(view: self.noDataView)
                        
                        self.lblRRP.text = "\(self.getCBAmountTransferArr[0].rRP ?? "0.0")"
                        self.lblTransferrableAmnt.text = "\(self.getCBAmountTransferArr[0].transferrableAmount ?? "0.0")"
                        self.lblVoidAmnt.text = "\(self.getCBAmountTransferArr[0].voidAmountTotal ?? "0.0")"
                        
                        let transferringAmount = self.getCBAmountTransferArr.compactMap({(Double($0.transferingAmount ?? "0.0"))})
                        let totaltransferringAmount = transferringAmount.reduce(0, +)
                        
                        let voidAmount = self.getCBAmountTransferArr.compactMap({(Double($0.voidAmountCB ?? "0.0"))})
                        let totalvoidAmount = voidAmount.reduce(0, +)
                        print("Total transferringAmount and totalvoidAmount - - - -", totaltransferringAmount," - - - - ",totalvoidAmount)
                        
                        self.lblTotalVoidAmnt.text = String(totalvoidAmount)
                        self.lblTotalTransferrableAmnt.text = String(totaltransferringAmount)
                        
                        self.heightConstraint.constant = CGFloat((self.getCBAmountTransferArr.count * 35) + 260)
                    }else{
                        self.noDataView.showView(view: self.noDataView, from: "NDA")
                    }
                    
                }
                catch let errorData {
                    ViewControllerUtils.sharedInstance.removeLoader()
                    self.noDataView.showView(view: self.noDataView, from: "NDA")
                    print(errorData.localizedDescription)
                }
            }
            
        }) { (Error) in
            ViewControllerUtils.sharedInstance.removeLoader()
            print(Error?.localizedDescription)
            self.noDataView.showView(view: self.noDataView, from: "ERR")
        }
    }
    
    
    // - -  - - - - - - API to transfer amount to counter boy - - - - - - - - -
    func apiCBAmountTransferUpdate(){
        ViewControllerUtils.sharedInstance.showLoader()
        
        // - - -- - - call api here
        let json: [String: Any] = ["FromDate": strFromDate,
                                   "ToDate": strToDate,
                                   "UserId": userId,
                                   "TransferType": intTransferType,
                                   "SchemeType": intSchemeType,
                                   "TransferDescription": edtDescription.text ?? "",
                                   "UserCategory": userCat,
                                   "MobileNo": mobileNo,
                                   "DeviceId": deviceId,
                                   "OrganizationId": GlobalConstants.init().ORGANIZATION_ID]
        
        print("json amount transfer update - - -  ", json," - - - ",cbAmountTransferUpdateApi)
        
        DataManager.shared.makeAPICall(url: cbAmountTransferUpdateApi, params: json, method: .POST, token: "-", success: { (response) in
            let data = response as? Data
            
            DispatchQueue.main.async {
                
                do {
                    self.CBAmountTransferUpdateElementMain = try JSONDecoder().decode(CommonUpdateData.self, from: data!)
                    
                    let status = self.CBAmountTransferUpdateElementMain.statusCode
                    
                    print("CBAmountTransferUpdateElementMain - - -  - - ",self.CBAmountTransferUpdateElementMain)
                    
                    if(status == 200){
                        self.CBAmountTransferUpdateData = self.CBAmountTransferUpdateElementMain.data ?? []
                        let msg = self.CBAmountTransferUpdateData[0].statusMessage ?? ""
                        Utility.showMessage(title: "Success", msg:msg)
                        ViewControllerUtils.sharedInstance.removeLoader()
                     
                    }else{
                        ViewControllerUtils.sharedInstance.removeLoader()
                        Utility.showMessage(title: "Failed", msg: "Transferring Amount failed at this moment")
                    }
                  
                }
                catch let errorData {
                    ViewControllerUtils.sharedInstance.removeLoader()
                    Utility.showMessage(title: "Failed", msg: "No Data available")
                    print(errorData.localizedDescription)
                }
            }
            
        }) { (Error) in
            ViewControllerUtils.sharedInstance.removeLoader()
            Utility.showMessage(title: "Failed", msg: "Server Error")
            print(Error?.localizedDescription)
        }
    }
    
    
    
    @IBAction func fromDate_clicked(_ sender: UIButton) {
        sender.isSelected = true
        let sb = UIStoryboard(name: "DatePicker", bundle: nil)
        
        let popup = sb.instantiateInitialViewController()  as? DatePickerController
        popup?.fromDate = fromDate
        popup?.toDate = toDate
        popup?.isFromDate = true
        popup?.delegate = self
        self.present(popup!, animated: true)
    }
    
    
    @IBAction func toDate_clicked(_ sender: UIButton) {
        sender.isSelected = true
        let sb = UIStoryboard(name: "DatePicker", bundle: nil)
        
        let popup = sb.instantiateInitialViewController()  as? DatePickerController
        popup?.delegate = self
        popup?.toDate = toDate
        popup?.fromDate = fromDate
        popup?.isFromDate = false
        self.present(popup!, animated: true)
    }
    
   
    
    func updateDate(value: String, date: Date) {
        if btnFromDate.isSelected {
            btnFromDate.setTitle(value, for: .normal)
            btnFromDate.isSelected = false
            fromDate = date
            strFromDate = Utility.formattedDateFromString(dateString: value, withFormat: "MM/dd/yyyy")!
        }
        else
        {
            btnToDate.setTitle(value, for: .normal)
            btnToDate.isSelected = false
            toDate = date
            strToDate = Utility.formattedDateFromString(dateString: value, withFormat: "MM/dd/yyyy")!
        }
    }
    
    
    
    @IBAction func clicked_back(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
    }
    
    @IBAction func clicked_submit(_ sender: Any) {
        if(intSchemeType == -1){
            Utility.showMessage(title: "Invalid", msg: "Please select scheme type")
        }
//        else if(intTransferType == -1){
//            Utility.showMessage(title: "Invalid", msg: "Please select transfer type")
//        }
        else{
            if (Utility.isConnectedToNetwork()) {
                print("Internet connection available")
                self.apiCBAmountTransferDetail()
                self.noDataView.hideView(view: self.noDataView)
            }
            else{
                print("No internet connection available")
                Utility.showMessage(title: "No Internet Connection", msg: "Make sure your device is connected to the internet.")
                self.noDataView.showView(view: self.noDataView, from: "NET")
            }
        }
    }
    
    @IBAction func clicked_transfer(_ sender: Any) {
        if(intSchemeType == -1){
            Utility.showMessage(title: "Invalid", msg: "Please select scheme type")
        }
//        else if(intTransferType == -1){
//            Utility.showMessage(title: "Invalid", msg: "Please select transfer type")
//        }
        else if(edtDescription.text?.isEmpty ?? true){
            Utility.showMessage(title: "Invalid", msg: "Please enter valid description")
        }else{
            if (Utility.isConnectedToNetwork()) {
                print("Internet connection available")
                self.apiCBAmountTransferUpdate()
            }
            else{
                print("No internet connection available")
                Utility.showMessage(title: "No Internet Connection", msg: "Make sure your device is connected to the internet.")
            }
        }
        
    }
    
    @IBAction func clicked_cancel(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
    }
    
    @objc func clickSchemeType(_ sender:UITapGestureRecognizer){
        let sb = UIStoryboard(name: "CommonPicker", bundle: nil)
        let popup = sb.instantiateInitialViewController()  as? CommonDropdown
        popup?.callFrom = 11
        popup?.getSchemeListArr = self.getSchemeListArr
        popup?.delegate = self
        self.present(popup!, animated: true)
    }
    
    
    func updatePositionValue(value: String, position: Int, callFrom: Int) {
        print("New Position - - - -",position)
        if(callFrom == 11){
            intSchemeType = position
            lblSchemeType.text = value
        }else if(callFrom == 12){
            intTransferType = position
            lblTransferType.text = value
        }
    }
    
    @objc func clickTransferType(_ sender:UITapGestureRecognizer){
        let sb = UIStoryboard(name: "CommonPicker", bundle: nil)
        let popup = sb.instantiateInitialViewController()  as? CommonDropdown
        popup?.callFrom = 12
        popup?.delegate = self
        self.present(popup!, animated: true)
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getCBAmountTransferArr.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CBAmountTransferCell", for: indexPath) as! CBAmountTransferCell
        
        cell.lblCounterBoyName.text = self.getCBAmountTransferArr[indexPath.row].counterboyName ?? ""
        cell.lblCounterBoyStatus.text = self.getCBAmountTransferArr[indexPath.row].status ?? ""
        cell.lblCounterBoyVoidAmnt.text = self.getCBAmountTransferArr[indexPath.row].voidAmountCB ?? ""
        cell.lblCounterBoyTransferringAmnt.text = self.getCBAmountTransferArr[indexPath.row].transferingAmount ?? ""
        
        return cell
    }
    
}
