import UIKit
import FirebaseAnalytics

class NotificationController:  BaseViewController,UITableViewDelegate,UITableViewDataSource{
    
    var NotificationElementMain = [NotiTotalElement]()
    var NotificationArray = [NotificationObject]()
    
    var NotificationReadElementMain = [NotificationReadElement]()
    var NotificationReadObjMain = [NotificationReadObj]()
    
    @IBOutlet weak var menuNotification: UIBarButtonItem!
    @IBOutlet weak var noDataView: NoDataView!
    @IBOutlet weak var tableView: UITableView!
    
    var strCin = ""
    var NotificationApi = ""
    var ReadNotificationApi = ""
    var deviceId = ""
    var arrNotificationId = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noDataView.hideView(view: self.noDataView)
        
        // Do any additional setup after loading the view.
        addSlideMenuButton()
        
        Analytics.setScreenName("NOTIFICATION SCREEN", screenClass: "NotificationController")
        SQLiteDB.instance.addAnalyticsData(ScreenName: "NOTIFICATION SCREEN", ScreenId: Int64(GlobalConstants.init().NOTIFICATION))
        
        let loginData =  UserDefaults.standard.value(forKey: "loginData") as? Dictionary ?? [:]
        strCin = loginData["userlogid"] as? String ?? ""
        
        let initialData =  UserDefaults.standard.value(forKey: "initialData") as? Dictionary ?? [:]
        NotificationApi = (initialData["baseApi"] as? String ?? "")+""+(initialData["sendNotification"] as? String ?? "")
        ReadNotificationApi = (initialData["baseApi"] as? String ?? "")+""+(initialData["addLogToRead"] as? String ?? "")
        
//        NotificationApi = "https://api.goldmedalindia.in//api/getSendNontification"
//        ReadNotificationApi = "https://api.goldmedalindia.in//api/AddLogToRead"
        
        if (Utility.isConnectedToNetwork()) {
            print("Internet connection available")
            OperationQueue.main.addOperation {
                self.apiNotification()
            }
            self.noDataView.hideView(view: self.noDataView)
        }
        else {
            print("No internet connection available")
            
            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            self.noDataView.showView(view: self.noDataView, from: "NET")
        }
        
        deviceId = UIDevice.current.identifierForVendor!.uuidString
        if(deviceId.isEqual("")){
            deviceId = "-"
        }
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
   
    }
    
    
    
    
    func apiNotification() -> Void {
        ViewControllerUtils.sharedInstance.showLoader()
        
        let json: [String: Any] = ["CIN":strCin,"ClientSecret":"ClientSecret"]
        
        DataManager.shared.makeAPICall(url: NotificationApi, params: json, method: .POST, success: { (response) in
            let data = response as? Data
            
            DispatchQueue.main.async {
                do {
                    self.NotificationElementMain = try JSONDecoder().decode([NotiTotalElement].self, from: data!)
                    self.NotificationArray = self.NotificationElementMain[0].data
                    
                    var tempNotiId = "-1"
                    
                    for i in 0...(self.NotificationArray.count - 1){
                        if(!(self.NotificationArray[i].isread ?? false)!){
                            tempNotiId = String(self.NotificationArray[i].slno ?? -1)
                            if(Int(tempNotiId) != -1){
                                 self.arrNotificationId.append(tempNotiId)
                            }
                           
                        }
                    }
               
                }
                catch let errorData {
                    print(errorData.localizedDescription)
                }
                
                
                if(self.tableView != nil)
                {
                    self.tableView.reloadData()
                }
                
                if(self.NotificationArray.count>0){
                    self.noDataView.hideView(view: self.noDataView)
                    if(self.arrNotificationId.count>0){
                        self.apiNotifyReadNotification()
                    }
                }else{
                    self.noDataView.showView(view: self.noDataView, from: "NDA")
                }
                
            }
            ViewControllerUtils.sharedInstance.removeLoader()
            
        }) { (Error) in
            ViewControllerUtils.sharedInstance.removeLoader()
            print(Error?.localizedDescription)
            self.noDataView.showView(view: self.noDataView, from: "ERR")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotificationArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationListCell", for: indexPath) as! NotificationCell
        
        cell.lblTitle.text = NotificationArray[indexPath.row].body?.capitalized ?? "-"
        cell.lblHeader.text = NotificationArray[indexPath.row].title?.capitalized ?? "-"
        cell.lblDateTime.text = NotificationArray[indexPath.row].date ?? "-"
        
        if(NotificationArray[indexPath.row].image == ""){
            cell.imvNotiImage.isHidden = true
        }else{
            cell.imvNotiImage.isHidden = false
            cell.imvNotiImage.sd_setImage(with: URL(string: NotificationArray[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "no_image_icon.png"))
        }
     
        
        if(NotificationArray[indexPath.row].isread ?? false){
            cell.vwNotiMain.backgroundColor = UIColor.white
        }else{
            cell.vwNotiMain.backgroundColor = UIColor.lightGray
        }


        return cell
    }
    
    // - - - - -  API to inform server of unread notification - - - -  - - -
    func apiNotifyReadNotification(){
      
        let json: [String: Any] = ["CIN":strCin,"ClientSecret":"645464","deviceid":deviceId,"NotificationId":(arrNotificationId.map{String($0)}).joined(separator: ",")]
        
        print("JSON READ NOTI - - ",json)
        
        DataManager.shared.makeAPICall(url: ReadNotificationApi, params: json, method: .POST, success: { (response) in
            let data = response as? Data
            
            DispatchQueue.main.async {
                do {
                    self.NotificationReadElementMain = try JSONDecoder().decode([NotificationReadElement].self, from: data!)
                    self.NotificationReadObjMain = self.NotificationReadElementMain[0].data
                    print("RESULT - - - ",self.NotificationReadObjMain[0].outresult)
                }
                catch let errorData {
                    print(errorData.localizedDescription)
                }
                
            }
           
        }) { (Error) in

            print(Error?.localizedDescription)
          
        }
        
    }
    
    
}
