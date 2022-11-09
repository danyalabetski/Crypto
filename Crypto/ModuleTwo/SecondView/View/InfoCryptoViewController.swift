import SnapKit
import UIKit

protocol InfoCryptoViewControllerProtocol: AnyObject {
    func setActivityIndicator(activated: Bool)
    func updateView()
}

final class DefaultInfoCryptoViewController: UIViewController {

    var presenter: InfoCryptoPresenter?

    private var nameLabel = UILabel()
    private var courseLabel = UILabel()
    private let assetIdLabel = UILabel()
    private let cryptoImageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    private var isRequestInProgress = false {
        didSet {
            if isRequestInProgress {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.requestCurrencyDetails()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = CustomColor.customColor

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

        assetIdLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(courseLabel.snp.bottom).inset(-10)
            make.height.equalTo(100)
        }

        cryptoImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.center.x)
            make.top.equalTo(assetIdLabel.snp.bottom).inset(-30)
            make.height.width.equalTo(250)
        }

        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.center.x)
            make.centerY.equalTo(view.center.y)
            make.width.height.equalTo(50)
        }
    }

    private func behaviorUIElement() {
        view.addViews(view: nameLabel, courseLabel, assetIdLabel, cryptoImageView, activityIndicator)
    }

    private func appearanceUIElement() {
        [nameLabel, courseLabel, assetIdLabel].forEach {
            $0.textAlignment = .center
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 12
            $0.backgroundColor = UIColor(red: 37 / 255, green: 35 / 255, blue: 51 / 255, alpha: 1.0)
        }

        nameLabel.font = .systemFont(ofSize: 20, weight: .medium)
        assetIdLabel.font = .systemFont(ofSize: 20, weight: .medium)
        courseLabel.textColor = .systemGreen
        courseLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        cryptoImageView.contentMode = .scaleAspectFit
    }

    private func updateView(model: CryptoDetailModel?, icon: UIImage?) {
        nameLabel.text = model?.name ?? "Invalid data"
        nameLabel.sizeToFit()

        cryptoImageView.image = icon

        let currencyTypeInfo = model?.isCryptoCurrency == nil
            ? "unknown type"
            : model?.isCryptoCurrency == 1 ? "crypto currency"
            : "fiat currency"
        assetIdLabel.text = String(format: "This is %@", currencyTypeInfo)

        let formattedPrice = model?.priceInUsd != nil ? String(format: "Price: $%.2f", model!.priceInUsd!) : "-"
        courseLabel.text = formattedPrice
    }
}

extension DefaultInfoCryptoViewController: InfoCryptoViewControllerProtocol {
    func setActivityIndicator(activated: Bool) {
        isRequestInProgress = activated
    }

    func updateView() {
        updateView(
            model: presenter?.cryptoModel,
            icon: presenter?.cryptoIcon
        )
    }
}
