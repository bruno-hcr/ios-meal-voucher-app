import Foundation

struct TransactionDetail {
    let name: String
    let date: Date
    let amount: Amount
    let smallIcon: TransactionDetail.Icon
    let largeIcon: TransactionDetail.Icon

    init(
        name: String,
        date: Date,
        amount: Amount,
        smallIcon: TransactionDetail.Icon,
        largeIcon: TransactionDetail.Icon
    ) {
        self.name = name
        self.date = date
        self.amount = amount
        self.smallIcon = smallIcon
        self.largeIcon = largeIcon
    }
}

extension TransactionDetail {
    struct Amount {
        let value: Double
        let symbol: String

        init(value: Double, symbol: String) {
            self.value = value
            self.symbol = symbol
        }
    }
}

extension TransactionDetail {
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
