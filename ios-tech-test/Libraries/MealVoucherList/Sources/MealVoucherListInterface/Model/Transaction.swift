import UIKit

public struct Transaction {
    public let name: String
    public let message: String?
    public let date: Date
    public let amount: Amount
    public let smallIcon: Transaction.Icon
    public let largeIcon: Transaction.Icon

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

extension Transaction {
    public enum Icon {
        case url(String)
        case category(IconImage)
    }

    public enum IconImage: String {
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

        public func toUIImage() -> UIImage? {
            switch self {
            case .computer:
                return UIImage(systemName: "desktopcomputer")
            case .bakery:
                return UIImage(systemName: "fork.knife")
            case .burger:
                return UIImage(systemName: "fork.knife")
            case .donation:
                return UIImage(systemName: "coloncurrencysign")
            case .gift:
                return UIImage(systemName: "gift")
            case .mealVoucher:
                return UIImage(systemName: "ticket")
            case .mobility:
                return UIImage(systemName: "car.fill")
            case .payment:
                return UIImage(systemName: "creditcard")
            case .supermarket:
                return UIImage(systemName: "cart")
            case .sushi:
                return UIImage(systemName: "fork.knife")
            case .train:
                return UIImage(systemName: "train.side.front.car")
            case .none:
                return nil
            }
        }
    }
}
