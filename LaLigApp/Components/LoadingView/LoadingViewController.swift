import UIKit

// MARK: - Protocol

protocol LoadingViewDelegate: class {
    func dismiss(completion: @escaping () -> Void)
    func updateTitle(with value: String)
    func updateCurrent(with value: Float)
    func updateTotal(with value: Int)
    func showAlertWith(title: String, content: String)
}

// Optional Methods
extension LoadingViewDelegate {
    func updateTitle(with value: String) { }
    func updateCurrent(with value: Float) { }
    func updateTotal(with value: Int) { }
    func showAlertWith(title: String, content: String) { }
}

// MARK: - Class

class LoadingViewController: UIViewController, LoadingViewDelegate {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var loadingLabelLeftSpacing: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.container.alpha = 0
        self.container.layer.cornerRadius = 10
        self.container.clipsToBounds = true
        
        self.activityView.startAnimating()
        self.loadingLabel.text = nil
        self.updateUI()
    }
    
    private func updateUI() {
        if self.loadingLabel.text == nil {
            self.loadingLabelLeftSpacing.constant = 0
        } else {
            self.loadingLabelLeftSpacing.constant = 10
        }
    }
    
    func dismiss(completion: @escaping () -> Void) {
        self.dismiss(animated: true, completion: completion)
    }
    
    func updateTitle(with value: String) {
        UIView.animate(withDuration: 0.3, animations: {
            self.container.alpha = 1
            self.loadingLabel.text = value
            self.updateUI()
        })
    }
    
}
