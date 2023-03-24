import Foundation
import MealVoucherListInterface
import XCTest

@testable import MealVoucherList

final class MealVoucherListRouteHandlerTests: XCTestCase {
    private let sut = MealVoucherListRouteHandler()

    func test_routes_shouldHasValidRoutes() {
        XCTAssertTrue(sut.routes.contains(where: { $0 is MealVoucherListRoute.Type }))
    }

    func test_destination_givenRoute_shouldReturnFeature() {
        let featureType = sut.destination(forRoute: MealVoucherListRoute())

        XCTAssertTrue(featureType is MealVoucherListFeature.Type)
    }
}
