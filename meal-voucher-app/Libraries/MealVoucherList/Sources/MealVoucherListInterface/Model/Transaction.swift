import CommonAssets
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

        public var image: UIImage? {
            switch self {
            case .computer:
                return Image.tech
            case .bakery:
                return Image.croissant
            case .burger:
                return Image.burger
            case .sushi:
                return Image.sushi
            case .gift:
                return Image.gift
            case .mealVoucher:
                return Image.forkKnife
            case .mobility:
                return Image.bike
            case .supermarket, .donation, .payment:
                return Image.drink
            case .train:
                return Image.subway
            case .none:
                return nil
            }
        }
        
        public var backgroundColor: UIColor {
            switch self {
            case .computer:
                return UIColor(red: 0.996, green: 0.878, blue: 0.941, alpha: 1)
            case .train:
                return UIColor(red: 0.996, green: 0.878, blue: 0.882, alpha: 1)
            default:
                return UIColor(red: 1, green: 0.922, blue: 0.831, alpha: 1)
            }
        }
    }
}
