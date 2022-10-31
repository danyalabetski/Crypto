import UIKit

protocol CryptoTrackerRouterInput {
    func detailNextScreen(for id: String)
}

final class CryptoTrackerRouter {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        let view = DefaultCryptoTrackerView()
        let presenter = DefaultCryptoTrackerPresenter(view: view, router: self)
        view.presenter = presenter
        navigationController.pushViewController(view, animated: true)
    }
}

extension CryptoTrackerRouter: CryptoTrackerRouterInput {
    func detailNextScreen(for id: String) {
        _ = InfoCryptoRouter(navigationController: navigationController, currencyId: id)
    }
}
