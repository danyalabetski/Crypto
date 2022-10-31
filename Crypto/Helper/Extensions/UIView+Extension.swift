import UIKit

extension UIView {
    func addViews(view: UIView...) {
        view.forEach(addSubview(_:))
    }
    
    func noneMaskIntoConstraints(view: UIView...) {
        view.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
