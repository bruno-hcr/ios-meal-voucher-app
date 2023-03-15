import Foundation
import NetworkInterface

struct TransactionsRequest: NetworkRequest {
    let path: String = "transactions.json"
    let method: HTTPMethod = .get
}
