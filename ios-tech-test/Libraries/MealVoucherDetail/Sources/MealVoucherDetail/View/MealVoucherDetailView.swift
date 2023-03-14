import Components
import UIKit

protocol MealVoucherDetailViewProtocol {
    
}

final class MealVoucherDetailView: UIView, MealVoucherDetailViewProtocol {
    
    struct ViewModel {
        
    }
    
    private var viewModel: ViewModel?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

extension MealVoucherDetailView: ViewCode {
    func setupSubViews() {
    }
    
    func setupConstraints() {

    }
}
