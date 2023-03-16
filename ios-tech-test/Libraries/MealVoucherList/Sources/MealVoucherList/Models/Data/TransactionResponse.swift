import Foundation

struct TransactionResponse: Codable {
    let transactions: [Transaction]
}

extension TransactionResponse {
    struct Transaction: Codable {
        let name: String
        let type: String
        let date: Date
        let message: String?
        let amount: Amount
        let smallIcon: Icon
        let largeIcon: Icon

        enum CodingKeys: String, CodingKey {
            case name, type, date, message, amount
            case smallIcon = "small_icon"
            case largeIcon = "large_icon"
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.type = try container.decode(String.self, forKey: .type)

            let dateString = try container.decode(String.self, forKey: .date)
            let dateFormatter = DateFormatter()

            // 2021-03-07T14:04:45.000+01:00
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            guard let date = dateFormatter.date(from: dateString) else { throw InvalidDateSerializer() }
            self.date = date

            self.message = try container.decodeIfPresent(String.self, forKey: .message)
            self.amount = try container.decode(Amount.self, forKey: .amount)
            self.smallIcon = try container.decode(Icon.self, forKey: .smallIcon)
            self.largeIcon = try container.decode(Icon.self, forKey: .largeIcon)
        }
    }

    struct InvalidDateSerializer: Error {}
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
