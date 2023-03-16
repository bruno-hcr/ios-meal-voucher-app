import Foundation

public struct Transaction {
    public let name: String
    public let message: String?
    public let date: Date
    public let amount: Amount
    public let smallIcon: Transaction.Icon
    public let largeIcon: Transaction.Icon

    public init(
        name: String,
        message: String,
        date: Date,
        amount: Amount,
        smallIcon: Transaction.Icon,
        largeIcon: Transaction.Icon
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
        let value: Double
        let symbol: String

        public init(value: Double, symbol: String) {
            self.value = value
            self.symbol = symbol
        }
    }
}

extension Transaction {
    public enum Icon: String {
        case bakery
        case burger
        case computer
        case donation
        case gift
        case mealVoucher = "meal_voucher"
        case mobility
        case payment
        case supermarket
        case sushi
        case train
        case none
    }
}
