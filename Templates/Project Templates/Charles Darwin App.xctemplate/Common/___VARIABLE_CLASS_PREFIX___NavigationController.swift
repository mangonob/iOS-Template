//___FILEHEADER___

import UIKit

class ___VARIABLE_CLASS_PREFIX___NavigationController: UINavigationController {
    
    /**
     * replace system defines pop gesture recognizer with custom UIPanGestureRecognizer.
     */
    private var _interactivePopGestureRecognizer: UIPanGestureRecognizer?
    override var interactivePopGestureRecognizer: UIGestureRecognizer?
    {
        get {
            super.interactivePopGestureRecognizer?.isEnabled = false
            
            if _interactivePopGestureRecognizer == nil {
                /** something privated */
                let selectorName = "handleNavigationTransition:"
                _interactivePopGestureRecognizer = UIPanGestureRecognizer(target: super.interactivePopGestureRecognizer?.delegate,
                                                                          action: Selector(selectorName))
                view.addGestureRecognizer(_interactivePopGestureRecognizer!)
            }
            
            return _interactivePopGestureRecognizer
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
