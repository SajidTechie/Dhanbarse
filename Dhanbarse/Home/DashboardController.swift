
import UIKit

class DashboardController: BaseViewController {
    
    @IBOutlet weak var menuDashboard: UIBarButtonItem!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
         addSlideMenuButton()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
}

