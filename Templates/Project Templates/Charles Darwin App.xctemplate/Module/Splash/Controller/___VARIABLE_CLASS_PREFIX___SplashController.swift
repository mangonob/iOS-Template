//___FILEHEADER___

import UIKit

class ___VARIABLE_CLASS_PREFIX___SplashController: ___VARIABLE_CLASS_PREFIX___BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerAction(_:)), userInfo: nil, repeats: true)
    }
    
    private var timerCount = 0
    @objc func timerAction(_ sender: Timer) {
        timerCount += 1
        
        if timerCount >= 1 {
            splash()
        }
    }
    
    func splash() {
        // After splash
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
