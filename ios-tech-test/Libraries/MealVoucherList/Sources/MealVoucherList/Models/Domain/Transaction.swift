import Foundation

struct Transaction {
    let name: String
    let message: String?
    let date: Date
    let amount: Amount
    let smallIcon: Transaction.Icon
    let largeIcon: Transaction.Icon
    
    init(
        name: String,
        message: String,
        date: Date,
        amount: Amount,
        smallIcon: Transaction.Icon,
        largeIcon: Transaction.Icon
    ) {
        self.name = name
        self.message = message
        self.date = date
        self.amount = amount
        self.smallIcon = smallIcon
        self.largeIcon = largeIcon
    }
}

extension Transaction {
    struct Amount {
        let value: Double
        let symbol: String
        
        init(value: Double, symbol: String) {
            self.value = value
            self.symbol = symbol
        }
    }
}

extension Transaction {
    enum Icon: String {
        case bakery
        case burger
        case computer
        case donation
        case gift
        case mealVoucher = "meal_voucher"
        case mobility
        case payment
        case supermarket
        case sushi
        case train
        case none
    }
}
