import Foundation
import MealVoucherListInterface
import NetworkInterface

protocol TransactionServiceProtocol {
    func getTransactionList(completion: @escaping (Result<[Transaction], Error>) -> Void)
}

final class TransactionService: TransactionServiceProtocol {
    private let network: HTTPClientProtocol

    init(network: HTTPClientProtocol) {
        self.network = network
    }

    func getTransactionList(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        let request = TransactionsRequest()

        network.request(request) {

        }
    }
}
