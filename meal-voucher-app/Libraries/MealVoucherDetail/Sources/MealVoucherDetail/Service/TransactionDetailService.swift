import Foundation
import MealVoucherDetailInterface

protocol TransactionDetailServiceProtocol {
    func getTransactionDetail(completion: @escaping (Result<TransactionDetail, Never>) -> Void)
}

final class TransactionDetailService: TransactionDetailServiceProtocol {
    private let transactionDetail: TransactionDetail

    init(transactionDetail: TransactionDetail) {
        self.transactionDetail = transactionDetail
    }

    func getTransactionDetail(completion: @escaping (Result<TransactionDetail, Never>) -> Void) {
        completion(.success(transactionDetail))
    }
}
