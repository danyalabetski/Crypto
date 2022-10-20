import Alamofire

final class NetworkManager {

    static let networkManager = NetworkManager()
    
    private var icons: [IconModel] = []
    
    private enum Constants {
        static let baseURL = "https://rest.coinapi.io/v1"
    }

    private enum EndPoints {
        static let assets = "/assets"
    }

    private let header: HTTPHeaders = ["X-CoinAPI-Key": "EFEDB87F-9742-4BF9-BC81-360E170CFD4B"]
    
    func getAPI(completion: @escaping (_ apiData: [CustomCryptoModel]) -> Void) {
        AF.request(Constants.baseURL + EndPoints.assets,
                   method: .get,
                   headers: header).responseDecodable(of: [CryptoModel].self) { data in
            switch data.result {
            case .failure(let error): print(error.localizedDescription)
            case .success(let data):
                let convertedModels = data.map(ConvertModel.instance.convert)
                completion(convertedModels)
            }
        }
    }

    func getApiImages(completion: @escaping (_ apiData: [IconModel]) -> Void) {
        AF.request(Constants.baseURL + EndPoints.assets + "/icons/55/?apikey=",
                   method: .get,
                   headers: header).responseDecodable(of: [IconModel].self) { response in
            self.icons = response.value ?? []
            completion(self.icons)
        }
    }
    
    private init() {}
}
