import SnapKit
import UIKit

final class InfoCryptoViewController: UIViewController {

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .orange
        return label
    }()
    
    private var courseLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .orange
        return label
    }()
    
    var name = ""
    var course = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        courseLabel.text = course
        

        behaviorUIElement()
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
            make.bottom.equalToSuperview().inset(100)
            make.height.equalTo(100)
        }
    }

    private func behaviorUIElement() {
        [nameLabel, courseLabel].forEach {
            view.addSubview($0)
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 12
        }
    }
}
