struct CustomCryptoModel: Codable {
    let assetId: String?
    let name: String?
    let typyIsCrypto: Int?
    let volume1mthUsd: Double?
    let priceUsd: Double?
}

struct ConvertModel {
    static let instance = ConvertModel()

    func convert(_ serverModel: CryptoModel) -> CustomCryptoModel {
        let assetId = serverModel.asset_id ?? ""
        let typeIsCrypto = serverModel.type_is_crypto ?? 0
        let name = serverModel.name ?? ""
        let volume1mthUsd = serverModel.volume_1mth_usd ?? 0
        let priceUsd = serverModel.price_usd ?? 0

        let clientModel = CustomCryptoModel(assetId: assetId, name: name, typyIsCrypto: typeIsCrypto, volume1mthUsd: volume1mthUsd, priceUsd: priceUsd)
        return clientModel
    }

    private init() {}
}
