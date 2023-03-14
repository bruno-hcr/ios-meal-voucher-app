import Foundation

struct TransactionResponse: Codable {
    let transactions: [Transaction]
}

extension TransactionResponse {
    struct Transaction: Codable {
        let name: String
        let type: String
        let date: String
        let message: String?
        let amount: Amount
        let smallIcon: Icon
        let largeIcon: Icon

        enum CodingKeys: String, CodingKey {
            case name, type, date, message, amount
            case smallIcon = "small_icon"
            case largeIcon = "large_icon"
        }
    }
}

extension TransactionResponse {
    struct Amount: Codable {
        let value: Double
        let currency: Currency
    }
}

extension TransactionResponse {
    struct Currency: Codable {
        let iso3: String
        let symbol: String
        let title: String

        enum CodingKeys: String, CodingKey {
            case iso3 = "iso_3"
            case symbol, title
        }
    }
}

extension TransactionResponse {
    struct Icon: Codable {
        let url: String?
        let category: String
    }
}
