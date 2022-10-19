import Alamofire

final class APICaller {
    static let shared = APICaller()
    
    private enum Constants {
        static let baseURL = "https://rest.coinapi.io/v1"
    }

    private enum EndPoints {
        static let assets = "/assets"
    }

    private let header: HTTPHeaders = ["X-CoinAPI-Key": "EFEDB87F-9742-4BF9-BC81-360E170CFD4B"]
    
    func getAllCryptoData(completion: @escaping(_ apiData: CryptoModel) -> Void) {
        AF.request(Constants.baseURL + EndPoints.assets,
                   method: .get,
                   headers: header).responseDecodable(of: CryptoModel.self) { data in
            switch data.result {
            case .failure(let error): print(error.localizedDescription)
            case .success(let cryptoData): completion(cryptoData)
            }
        }
    }
    
    private init() {}
}
