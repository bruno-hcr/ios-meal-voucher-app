import CommonAssets
import Foundation

public struct Transaction {
    public let name: String
    public let message: String?
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
        self.message = message
        self.date = date
        self.amount = amount
        self.smallIcon = smallIcon
        self.largeIcon = largeIcon
    }
}

extension Transaction {
    public struct Amount {
        public let value: Double
        public let symbol: String

        public init(value: Double, symbol: String) {
            self.value = value
            self.symbol = symbol
        }
    }
}
