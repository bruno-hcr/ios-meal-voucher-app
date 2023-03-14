import Foundation
import Network

struct TransactionsRequest: NetworkRequest {
    let path: String = "transactions.json"
    let method: Network.HTTPMethod = .get
}
