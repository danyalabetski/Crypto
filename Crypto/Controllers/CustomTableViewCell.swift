import SnapKit
import UIKit

final class CustomTableViewCell: UITableViewCell {

    static let cell = "Cell"
    
    private let nameCryptoLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let courseCryptoLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = UIColor(red: 37 / 255, green: 35 / 255, blue: 51 / 255, alpha: 1.0)

        behaviorTableViewCell()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutLabel()
    }

    private func layoutLabel() {

        nameCryptoLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(5)
        }

        courseCryptoLabel.snp.makeConstraints { make in
            make.right.bottom.top.equalToSuperview().inset(5)
        }
    }

    private func behaviorTableViewCell() {
        [nameCryptoLabel, courseCryptoLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    func setLabel(name: String, course: String) {
        nameCryptoLabel.text = name
        courseCryptoLabel.text = "$" + course
    }

    private func appearanceLabels() {
        nameCryptoLabel.font = UIFont(name: "Undertale_Battle_Font", size: 30)
    }
}
