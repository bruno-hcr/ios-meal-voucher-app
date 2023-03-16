import Foundation
import MealVoucherListInterface

extension Transaction {
    static func map(from response: TransactionResponse.Transaction) -> Self {
        .init(
            name: "",
            message: "",
            date: Date(),
            amount: .init(value: 0.0, symbol: ""),
            smallIcon: .none,
            largeIcon: .none
        )
    }
}
