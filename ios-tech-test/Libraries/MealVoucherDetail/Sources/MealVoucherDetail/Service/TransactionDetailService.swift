import Foundation
import MealVoucherListInterface

protocol TransactionDetailServiceProtocol {
    func getTransaction(completion: @escaping (Result<Transaction, Error>) -> Void)
}

final class TransactionDetailService: TransactionDetailServiceProtocol {
    private let transaction: Transaction

    init(transaction: Transaction) {
        self.transaction = transaction
    }

    func getTransaction(completion: @escaping (Result<Transaction, Error>) -> Void) {
        completion(.success(transaction))
    }
}
