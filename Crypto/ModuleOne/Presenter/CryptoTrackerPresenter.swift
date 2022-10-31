protocol CryptoTrackerPresenter {
    var currenciesArray: [CryptoModel] { get }
    func currencyCellDidTapped(id: String)
    func requestCurrencies()
}

final class DefaultCryptoTrackerPresenter: CryptoTrackerPresenter {

    unowned let view: CryptoTracker
    private let router: CryptoTrackerRouterInput
    var currenciesArray: [CryptoModel] = []

    init(view: CryptoTracker, router: CryptoTrackerRouterInput) {
        self.view = view
        self.router = router
    }

    func currencyCellDidTapped(id: String) {
        router.detailNextScreen(for: id)
    }

    func requestCurrencies() {
        view.setActivityIndicator(activated: true)

        NetworkManager.shared.getAPI { [weak self] apiData in
            self?.view.setActivityIndicator(activated: false)

            switch apiData {
            case .failure(let error): print(error.localizedDescription)
            case .success(let data):
                self?.currenciesArray = data
                self?.view.reloadData()
            }
        }
    }
}
