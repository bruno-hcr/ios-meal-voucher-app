import Foundation
import MealVoucherListInterface

extension Transaction {
    static func map(from response: TransactionResponse.Transaction) -> Self {
        .init(
            name: response.name,
            message: response.message,
            date: response.date,
            amount: .map(from: response.amount),
            smallIcon: .map(
                fromUrl: response.smallIcon.url,
                andCategory: response.smallIcon.category
            ),
            largeIcon: .map(
                fromUrl: response.largeIcon.url,
                andCategory: response.largeIcon.category
            )
        )
    }
}

extension Transaction.Amount {
    static func map(from response: TransactionResponse.Amount) -> Self {
        .init(
            value: response.value,
            symbol: response.currency.symbol
        )
    }
}

extension Transaction.Icon {
    static func map (fromUrl url: String?, andCategory category: String) -> Self {
        guard let url else {
            let iconImage = Transaction.IconImage(rawValue: category) ?? .none
            return .category(iconImage)
        }

        return .url(url)
    }
}
