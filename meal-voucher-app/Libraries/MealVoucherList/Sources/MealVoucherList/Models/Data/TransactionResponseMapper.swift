import CommonAssets
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
