import SnapKit
import UIKit

final class InfoCryptoViewController: UIViewController {

    var cryptoModel: CryptoModel?

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
        getCryptoData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configurationLayout()
    }

    private func getCryptoData() {

        APICaller.shared.getAllCryptoData { [weak self] apiData in
            self?.cryptoModel = apiData
        }
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
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(assetIdLabel.snp.bottom).inset(-10)
            make.height.width.equalTo(100)
        }
    }

    private func behaviorUIElement() {
        [nameLabel, courseLabel, assetIdLabel, cryptoImageView].forEach {
            view.addSubview($0)
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 12
            $0.backgroundColor = UIColor(red: 37 / 255, green: 35 / 255, blue: 51 / 255, alpha: 1.0)
        }
    }

    private func appearanceUIElement() {
        [nameLabel, courseLabel, assetIdLabel].forEach {
            $0.textAlignment = .center
        }
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        courseLabel.textColor = .systemGreen
        
    }
}
