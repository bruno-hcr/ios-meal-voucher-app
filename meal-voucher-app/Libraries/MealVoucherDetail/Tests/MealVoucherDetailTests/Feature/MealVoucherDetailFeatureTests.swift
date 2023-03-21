import CommonAssets
import Foundation
import ImageFetcherInterface
import MealVoucherDetailInterface
import XCTest

@testable import MealVoucherDetail

final class MealVoucherDetailFeatureTests: XCTestCase {
    private lazy var sut = MealVoucherDetailFeature(
        imageFetcher: .init(resolvedValue: ImageFetcherProtocolDummy())
    )

    func test_build_shouldReturnViewController() {
        let viewController = sut.build(fromRoute: MealVoucherDetailRoute(transactionDetail: .fixture()))
        XCTAssertTrue(viewController is MealVoucherDetailViewController)
    }
}

final class ImageFetcherProtocolDummy: ImageFetcherProtocol {
    func fetchImage(with url: URL, imageView: UIImageView) {}
}

extension TransactionDetail {
    static func fixture(
        name: String = "",
        message: String? = nil,
        date: Date = Date(),
        amount: Amount = .fixture(),
        smallIcon: Icon = .category(.none),
        largeIcon: Icon = .category(.none)
    ) -> Self {
        .init(
            name: name,
            message: message,
            date: date,
            amount: amount,
            smallIcon: smallIcon,
            largeIcon: largeIcon
        )
    }
}

extension TransactionDetail.Amount {
    static func fixture(
        value: Double = 0.0,
        symbol: String = ""
    ) -> Self {
        .init(
            value: value,
            symbol: symbol
        )
    }
}
