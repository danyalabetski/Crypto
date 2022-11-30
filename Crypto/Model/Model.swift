struct CryptoModel: Codable {
    let asset_id: String
    let name: String?
    let price_usd: Double?
    let id_icon: String?
}

struct IconModel: Codable {
    let asset_id: String
    let url: String
}
