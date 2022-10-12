import SnapKit
import UIKit

final class InfoCryptoViewController: UIViewController {

    private var nameLabel = UILabel()
    private var courseLabel = UILabel()

    var name = ""
    var course = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "CustomColor")

        nameLabel.text = name
        courseLabel.text = "$" + course

        behaviorUIElement()
        appearanceUIElement()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configurationLayout()
    }

    private func configurationLayout() {
        nameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(100)
        }

        courseLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(nameLabel.snp.bottom).inset(-10)
            make.height.equalTo(100)
        }
    }

    private func behaviorUIElement() {
        [nameLabel, courseLabel].forEach {
            view.addSubview($0)
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 12
            $0.backgroundColor = UIColor(red: 37 / 255, green: 35 / 255, blue: 51 / 255, alpha: 1.0)
        }
    }
    
    private func appearanceUIElement() {
        [nameLabel, courseLabel].forEach({
            $0.textAlignment = .center
        })
    }
}
