import Foundation
import CommonAssets

public struct TransactionDetail {
    public let name: String
    public let date: Date
    public let amount: Amount
    public let smallIcon: Icon
    public let largeIcon: Icon

    public init(
        name: String,
        message: String?,
        date: Date,
        amount: Amount,
        smallIcon: Icon,
        largeIcon: Icon
    ) {
        self.name = name
        self.date = date
        self.amount = amount
        self.smallIcon = smallIcon
        self.largeIcon = largeIcon
    }
}

extension TransactionDetail {
    public struct Amount {
        public let value: Double
        public let symbol: String

        public init(value: Double, symbol: String) {
            self.value = value
            self.symbol = symbol
        }
    }
}
