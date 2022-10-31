import UIKit

protocol InfoCryptoRouterInput {
    func moveBack()
}

final class InfoCryptoRouter {

    private let navigationController: UINavigationController!

    init(navigationController: UINavigationController, currencyId: String) {
        self.navigationController = navigationController

        let view = DefaultInfoCryptoViewController()
        let presenter = DefaultInfoCryptoPresenter(id: currencyId, view: view)
        view.presenter = presenter

        navigationController.pushViewController(view, animated: true)
    }

    func moveBack() {
        navigationController.popViewController(animated: true)
    }
}
