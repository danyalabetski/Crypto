import SnapKit
import UIKit

final class SplashScreen: UIViewController {

    private let imageBackground: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        image.image = UIImage(named: "background")
        image.contentMode = .scaleToFill
        return image
    }()

    private let imageIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "money-currency")
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add Subview
        view.addSubview(imageBackground)
        view.addSubview(imageIcon)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageBackground.frame = view.bounds
        imageIcon.center = view.center

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animate()
        }
    }

    private func animate() {
        UIView.animate(withDuration: 1) {
            let size = self.view.frame.size.width * 1.5
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size

            self.imageIcon.frame = CGRect(x: -(diffX / 2),
                                          y: diffY / 2,
                                          width: size,
                                          height: size)
        }

        UIView.animate(withDuration: 1.5, animations: {
            self.imageIcon.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    let viewController = ViewController()
                    viewController.modalTransitionStyle = .crossDissolve
                    viewController.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(viewController, animated: false)
                }
            }
        })
    }
}
