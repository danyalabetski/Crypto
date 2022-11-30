struct CustomCryptoModel: Codable {
    let assetId: String?
    let name: String?
    let priceUsd: Double?
}

struct ConvertModel {
    static let instance = ConvertModel()

    func convert(_ serverModel: CryptoModel) -> CustomCryptoModel {
        let assetId = serverModel.asset_id ?? ""
        let name = serverModel.name ?? ""
        let priceUsd = serverModel.price_usd ?? 0

        let clientModel = CustomCryptoModel(assetId: assetId, name: name, priceUsd: priceUsd)
        return clientModel
    }

    private init() {}
}
