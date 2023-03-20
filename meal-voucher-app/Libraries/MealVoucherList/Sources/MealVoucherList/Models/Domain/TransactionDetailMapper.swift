import Foundation
import MealVoucherListInterface
import MealVoucherDetailInterface

extension TransactionDetail {
    static func map(from transaction: Transaction) -> Self {
        .init(
            name: transaction.name,
            message: transaction.message,
            date: transaction.date,
            amount: .map(from: transaction.amount),
            smallIcon: transaction.smallIcon,
            largeIcon: transaction.largeIcon
        )
    }
}

extension TransactionDetail.Amount {
    static func map(from amount: Transaction.Amount) -> Self {
        .init(value: amount.value, symbol: amount.symbol)
    }
}
