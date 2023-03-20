import Foundation
import RouterServiceInterface

public struct MealVoucherDetailRoute: Route {
    public static let identifier: String = "meal_voucher_detail"

    public let transactionDetail: TransactionDetail

    public init(transactionDetail: TransactionDetail) {
        self.transactionDetail = transactionDetail
    }
}
