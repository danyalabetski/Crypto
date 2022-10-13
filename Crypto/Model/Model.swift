struct CryptoModel: Codable {
    let asset_id: String?
    let data_symbols_count: Int?
    let name: String?
    let type_is_crypto: Int
    let volume_1day_usd: Double?
    let volume_1hrs_usd: Double?
    let volume_1mth_usd: Double?
}
