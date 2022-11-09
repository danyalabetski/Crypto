import UIKit

protocol InfoCryptoPresenter {
    var cryptoModel: CryptoDetailModel? { get }
    var cryptoIcon: UIImage? { get }

    func requestCurrencyDetails()
}

final class DefaultInfoCryptoPresenter: InfoCryptoPresenter {

    private var currencyId: String
    private unowned let view: InfoCryptoViewControllerProtocol

    init(id: String, view: InfoCryptoViewControllerProtocol) {
        self.view = view
        self.currencyId = id
    }

    var cryptoModel: CryptoDetailModel?
    var cryptoIcon: UIImage?

    func requestCurrencyDetails() {
        view.setActivityIndicator(activated: true)

        let group = DispatchGroup()
        group.enter()
        requestDetails(id: currencyId) { model in
            self.cryptoModel = model
            group.leave()
        }

        group.enter()
        requestIcon(id: currencyId) { image in
            self.cryptoIcon = image
            group.leave()
        }

        group.notify(queue: DispatchQueue.main) {
            self.view.updateView()
            self.view.setActivityIndicator(activated: false)
        }
    }

    // MARK: internal requests

    private func requestDetails(id: String, completion: @escaping (CryptoDetailModel?) -> Void) {
        NetworkManager.shared.getCurrencyDetails(ids: id) { result in
            var model: CryptoDetailModel?
            switch result {
            case .success(let models):
                model = models[0]
            case .failure(let error):
                print(error)
            }

            completion(model)
        }
    }

    private func requestIcon(id: String, completion: @escaping (UIImage?) -> Void) {
        NetworkManager.shared.getCurrencyIcon { result in
            let group = DispatchGroup()
            var image: UIImage?

            switch result {
            case .success(let icons):
                if let icon = icons.first(where: { $0.id == id }) {
                    group.enter()
                    NetworkManager.shared.downloadImage(url: icon.iconUrl) { result in
                        switch result {
                        case .success(let downloadedImage):
                            image = downloadedImage
                        case .failure(let error):
                            print(error)
                        }

                        group.leave()
                    }
                }
            case .failure(let error):
                print(error)
            }

            group.notify(queue: DispatchQueue.global()) {
                completion(image)
            }
        }
    }
}
