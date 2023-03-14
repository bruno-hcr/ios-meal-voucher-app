import UIKit

final class MealVoucherDetailViewController: UIViewController {
    private let customView: MealVoucherDetailViewProtocol & UIView
    
    init(customView: MealVoucherDetailViewProtocol & UIView) {
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
