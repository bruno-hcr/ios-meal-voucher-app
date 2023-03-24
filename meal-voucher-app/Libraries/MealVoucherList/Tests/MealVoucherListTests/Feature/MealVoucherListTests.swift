import CommonAssets
import Foundation
import ImageFetcherInterface
import MealVoucherListInterface
import RouterServiceInterface
import XCTest

@testable import MealVoucherList

final class MealVoucherListFeatureTests: XCTestCase {
    private lazy var sut = MealVoucherListFeature(
        network: .init(resolvedValue: HTTPClientProtocolStub()),
        routerService: .init(resolvedValue: RouterServiceProtocolSpy()),
        imageFetcher: .init(resolvedValue: ImageFetcherProtocolDummy())
    )


    func test_build_shouldReturnViewController() {
        let viewController = sut.build(fromRoute: MealVoucherListRoute())
        XCTAssertTrue(viewController is MealVoucherListViewController)
    }
}

final class ImageFetcherProtocolDummy: ImageFetcherProtocol {
    func fetchImage(with url: URL, imageView: UIImageView) {}
}
