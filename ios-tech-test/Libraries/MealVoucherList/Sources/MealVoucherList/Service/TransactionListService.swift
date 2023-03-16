import Foundation
import MealVoucherListInterface
import NetworkInterface

protocol TransactionListServiceProtocol {
    func getTransactionList(completion: @escaping (Result<[Transaction], Error>) -> Void)
}

final class TransactionListService: TransactionListServiceProtocol {
    private let network: HTTPClientProtocol

    init(network: HTTPClientProtocol) {
        self.network = network
    }

    func getTransactionList(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        network.request(TransactionsRequest()) { (result: Result<TransactionResponse, Error>) in
            switch result {
            case .success(let transactionResponse):
                let domainTransactionList = transactionResponse.transactions.map(Transaction.map)
                completion(.success(domainTransactionList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
