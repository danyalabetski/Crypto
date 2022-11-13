struct CryptoModel: Codable {
    let id: String
    let name: String
    let priceInUsd: Double?

    enum CodingKeys: String, CodingKey {
        case id = "asset_id"
        case name
        case priceInUsd = "price_usd"
    }
}

extension CryptoModel: CustomStringConvertible {
    var description: String {
        let price = priceInUsd != nil ? String(format: "%.2f", priceInUsd!) : "-"
        return "\nName: \(name) (\(id)) / Price: \(price): \n-------"
    }
}

// MARK: currency icon

struct IconModel: Codable {
    let id: String
    let iconUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "asset_id"
        case iconUrl = "url"
    }
}
