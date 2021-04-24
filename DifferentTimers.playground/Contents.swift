import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 1. Delay with perform
        perform(#selector(self.colorFunc), with: nil, afterDelay: 2)
        
        // 2. Dispatch queue
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4){
            self.animateBackgroundColor(to: .yellow)
        }
        
        // 3. Timer schedueld timer
        Timer.scheduledTimer(withTimeInterval: 6, repeats: false) { (_) in
            self.animateBackgroundColor(to: .cyan)
        }
        
    }
    
    @objc func colorFunc() {
        animateBackgroundColor(to: .red)
    }
    
    fileprivate func animateBackgroundColor(to color: UIColor) {
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.view.backgroundColor = color
        })
    }
  
} // End of class ViewController
