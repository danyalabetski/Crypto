import SnapKit
import UIKit

final class CustomTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let cell = "Cell"

    // MARK: Public

    var cellDidTappedHandler: (() -> Void)?

    // MARK: Private

    private let nameCryptoLabel = UILabel()
    private let courseCryptoLabel = UILabel()
    private let iconImageView = UIImageView()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = CustomColor.customColor

        behaviorTableViewCell()
        appearanceLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layoutLabel()
    }

    // MARK: - Setups

    private func layoutLabel() {

        nameCryptoLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.left.equalTo(iconImageView.snp.right).inset(-5)
        }

        courseCryptoLabel.snp.makeConstraints { make in
            make.right.bottom.top.equalToSuperview().inset(5)
        }

        iconImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(5)
            make.width.height.equalTo(60)
        }
    }

    private func behaviorTableViewCell() {

        addViews(view: nameCryptoLabel, courseCryptoLabel, iconImageView)
        noneMaskIntoConstraints(view: nameCryptoLabel, courseCryptoLabel, iconImageView)

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTappedGestureRecognizer))
        addGestureRecognizer(gestureRecognizer)
    }

    func setLabel(name: String, course: Double?) {
        nameCryptoLabel.text = name

        let formattedPrice = course != nil ? String(format: "%.2f", course!) : "-"
        courseCryptoLabel.text = "$" + formattedPrice
    }

    func appearanceLabel() {
        nameCryptoLabel.font = .systemFont(ofSize: 20, weight: .medium)
        courseCryptoLabel.textColor = .systemGreen
        courseCryptoLabel.textAlignment = .right
        courseCryptoLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        iconImageView.contentMode = .scaleAspectFit
    }

    // MARK: - Helpers

    @objc private func didTappedGestureRecognizer() {
        cellDidTappedHandler?()
    }
}
