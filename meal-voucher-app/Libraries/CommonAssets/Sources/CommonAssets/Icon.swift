import UIKit

public enum Icon {
    case url(String)
    case category(IconImage)

    public static func map(fromUrl url: String?, andCategory category: String) -> Self {
        guard let url else {
            let iconImage = IconImage(rawValue: category) ?? .none
            return .category(iconImage)
        }

        return .url(url)
    }
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
    case vias
    case heart
    case interrogation
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
        case .vias:
            return Image.vias
        case .heart:
            return Image.heart
        case .interrogation:
            return Image.interrogation
        case .none:
            return nil
        }
    }

    public var backgroundColor: UIColor {
        switch self {
        case .computer:
            return .init(red: 0.996, green: 0.878, blue: 0.941, alpha: 1)
        case .train:
            return .init(red: 0.996, green: 0.878, blue: 0.882, alpha: 1)
        case .heart, .vias, .interrogation:
            return .init(red: 0.965, green: 0.965, blue: 0.973, alpha: 1)
        default:
            return .init(red: 1, green: 0.922, blue: 0.831, alpha: 1)
        }
    }
}
