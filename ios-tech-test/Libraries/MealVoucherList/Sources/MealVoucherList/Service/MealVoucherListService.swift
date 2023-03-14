import Foundation
import Network

protocol MealVoucherListServiceProtocol {
    func getTransactionList(completion: @escaping (Result<[Transaction], Error>) -> Void)
}

final class MealVoucherListService: MealVoucherListServiceProtocol {
    private let network: NetworkManager

    init(network: NetworkManager) {
        self.network = network
    }

    func getTransactionList(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        let request = TransactionsRequest()

        network.request(request) {

        }
    }
}
