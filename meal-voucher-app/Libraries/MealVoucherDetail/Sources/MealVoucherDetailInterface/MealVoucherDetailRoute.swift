import Foundation
import MealVoucherListInterface
import RouterServiceInterface

public struct MealVoucherDetailRoute: Route {
    public static let identifier: String = "meal_voucher_detail"

    public let transaction: Transaction

    public init(transaction: Transaction) {
        self.transaction = transaction
    }
}
