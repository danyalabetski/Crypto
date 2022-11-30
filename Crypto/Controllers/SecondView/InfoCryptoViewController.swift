import SnapKit
import UIKit

final class InfoCryptoViewController: UIViewController {

    private var nameLabel = UILabel()
    private var courseLabel = UILabel()
    private let assetIdLabel = UILabel()
    private let cryptoImageView = UIImageView()

    var name = ""
    var course = ""
    var assetId = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "CustomColor")

        nameLabel.text = name
        courseLabel.text = "$" + course
        assetIdLabel.text = assetId

        behaviorUIElement()
        appearanceUIElement()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configurationLayout()
    }
    
    func setupImage(image: IconModel) {
        self.cryptoImageView.setImage(imageUrl: image.url)
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

        assetIdLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(courseLabel.snp.bottom).inset(-10)
            make.height.equalTo(100)
        }

        cryptoImageView.snp.makeConstraints { make in
//            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(assetIdLabel.snp.bottom).inset(-10)
//            make.bottom.equalTo(20)
            make.height.width.equalTo(250)
        }
    }

    private func behaviorUIElement() {
        [nameLabel, courseLabel, assetIdLabel].forEach {
            view.addSubview($0)
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 12
            $0.backgroundColor = UIColor(red: 37 / 255, green: 35 / 255, blue: 51 / 255, alpha: 1.0)
        }
        view.addSubview(cryptoImageView)
    }

    private func appearanceUIElement() {
        [nameLabel, courseLabel, assetIdLabel].forEach {
            $0.textAlignment = .center
        }
        nameLabel.font = .systemFont(ofSize: 20, weight: .medium)
        assetIdLabel.font = .systemFont(ofSize: 20, weight: .medium)
        courseLabel.textColor = .systemGreen
        courseLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        cryptoImageView.contentMode = .scaleAspectFit
    }
}
