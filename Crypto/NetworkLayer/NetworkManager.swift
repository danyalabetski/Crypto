import Alamofire

private enum Constants {
    static let baseURL = "https://rest.coinapi.io/v1"
}

private enum EndPoints {
    static let assets = "/assets"
    static let assetsImage = "/assets/icons/55/?apikey="
}

private enum Header {
    static let header: HTTPHeaders = ["X-CoinAPI-Key": "EFEDB87F-9742-4BF9-BC81-360E170CFD4B"]
}

final class NetworkManager {

    static let shared = NetworkManager()

    func getAPI(completion: @escaping ((Result<[CryptoModel], AFError>) -> Void)) {
        AF.request(Constants.baseURL + EndPoints.assets,
                   method: .get,
                   headers: Header.header).responseDecodable(of: [CryptoModel].self) { data in
            completion(data.result)
        }
    }

    func getCurrencyDetails(ids: String, completion: @escaping ((Result<[CryptoDetailModel], AFError>) -> Void)) {
        let parameters: Parameters = ["filter_asset_id": ids]

        AF.request(
            Constants.baseURL + EndPoints.assets,
            method: .get,
            parameters: parameters,
            headers: Header.header
        ).responseDecodable(of: [CryptoDetailModel].self) { response in
            completion(response.result)
        }
    }

    func getCurrencyIcon(completion: @escaping ((Result<[IconModel], AFError>) -> Void)) {
        AF.request(
            Constants.baseURL + EndPoints.assetsImage,
            method: .get,
            headers: Header.header
        ).responseDecodable(of: [IconModel].self) { response in
            completion(response.result)
        }
    }

    func downloadImage(url: String, completion: @escaping ((Result<UIImage?, Error>) -> Void)) {
        AF.request(
            url,
            method: .get,
            headers: Header.header
        ).response { response in
            switch response.result {
            case .failure(let error): completion(.failure(error))
            case .success(let data): completion(.success(UIImage(data: data!, scale: 1)))
            }
        }
    }

    private init() {}
}
