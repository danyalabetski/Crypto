// MARK: detailed currency model

struct CryptoDetailModel: Codable {
   let id: String
   let name: String
   let isCryptoCurrency: Int
   let priceInUsd: Double?

   enum CodingKeys: String, CodingKey {
       case id = "asset_id"
       case name
       case isCryptoCurrency = "type_is_crypto"
       case priceInUsd = "price_usd"
   }
}
