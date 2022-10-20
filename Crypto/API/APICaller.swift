import Alamofire

final class APICaller {
    static let shared = APICaller()
    
    private var icons: [IconModel] = []
    private var iconsVcTwo: [IconModel] = []
    
    private enum Constants {
        static let baseURL = "https://rest.coinapi.io/v1"
    }

    private enum EndPoints {
        static let assets = "/assets"
    }

    private let header: HTTPHeaders = ["X-CoinAPI-Key": "EFEDB87F-9742-4BF9-BC81-360E170CFD4B"]
    
    func getAllCryptoData(completion: @escaping(_ apiData: [CryptoModel]) -> Void) {
        AF.request(Constants.baseURL + EndPoints.assets,
                   method: .get,
                   headers: header).responseDecodable(of: [CryptoModel].self) { data in
            switch data.result {
            case .failure(let error): print(error.localizedDescription)
            case .success(let cryptoData): completion(cryptoData)
            }
        }
    }
    
    func getAllIcons(completion: @escaping (_ apiData: [IconModel]) -> Void) {
        AF.request(Constants.baseURL + EndPoints.assets + "/icons/55/?apikey=",
                   method: .get,
                   headers: header).responseDecodable(of: [IconModel].self) { response in
            self.icons = response.value ?? []
            completion(self.icons)
        }
    }
    
    private init() {}
}
