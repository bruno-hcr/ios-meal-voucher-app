import UIKit

public enum MealVoucherListFactory {
    public static func make() -> UIViewController {
        let view = MealVoucherListView()

        let viewController = MealVoucherListViewController(
            customView: view
        )

        return viewController
    }
}
