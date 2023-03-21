import Foundation
import MealVoucherDetailInterface
import XCTest

@testable import MealVoucherDetail

final class TransactionDetailServiceTests: XCTestCase {
    private let expectedTransactionDetail = TransactionDetail.fixture()
    private let sut = TransactionDetailService(transactionDetail: .fixture())

    func foo() {
        var result: Result<TransactionDetail, Never>?

        sut.getTransactionDetail {
            result = $0
        }

        guard case .success = result else {
            return XCTFail()
        }
    }
}
