import UIKit

public protocol ViewAnimatable {
    var targetView: UIView { get }
}

public final class ViewAnimation: NSObject {
    private let transitionDuration: TimeInterval = 0.4
    private let isPresenting: Bool

    public init(isPresenting: Bool = false) {
        self.isPresenting = isPresenting
    }
    
    private func targetView(in viewController: UIViewController) -> UIView? {
        if let view = (viewController.view as? ViewAnimatable)?.targetView {
            return view
        }
        if let navigationController = viewController as? UINavigationController, let viewController = navigationController.topViewController,
           let view = (viewController.view as? ViewAnimatable)?.targetView {
            return view
        }
        return nil
    }
}

extension ViewAnimation: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using: UIViewControllerContextTransitioning?) -> TimeInterval {
        transitionDuration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }

        guard
            let fromTargetView = targetView(in: fromViewController),
                let toTargetView = targetView(in: toViewController) else {
            transitionContext.completeTransition(false)
            return
        }

        guard
            let fromImage = fromTargetView.snapshot(),
                let toImage = toTargetView.snapshot() else {
            transitionContext.completeTransition(false)
            return
        }

        let fromImageView = UIImageView(image: fromImage)
        fromImageView.clipsToBounds = true

        let toImageView = UIImageView(image: toImage)
        toImageView.clipsToBounds = true

        let startFrame = fromTargetView.frame(in: containerView)
        let endFrame = toTargetView.frame(in: containerView)

        fromImageView.frame = startFrame
        toImageView.frame = startFrame

        let cleanupClosure: () -> Void = {
            fromTargetView.isHidden = false
            toTargetView.isHidden = false
            fromImageView.removeFromSuperview()
            toImageView.removeFromSuperview()
        }

        let updateFrameClosure: () -> Void = {
            toViewController.view.setNeedsLayout()
            toViewController.view.layoutIfNeeded()

            let updatedEndFrame = toTargetView.frame(in: containerView)
            let correctedEndFrame = CGRect(origin: updatedEndFrame.origin, size: endFrame.size)
            fromImageView.frame = correctedEndFrame
            toImageView.frame = correctedEndFrame
        }

        let animationBlock: (() -> Void)
        let completionBlock: ((Bool) -> Void)

        fromTargetView.isHidden = true
        toTargetView.isHidden = true

        if isPresenting {
            guard let toView = transitionContext.view(forKey: .to) else {
                transitionContext.completeTransition(false)
                assertionFailure()
                return
            }
            containerView.addSubview(toView)
            containerView.addSubview(toImageView)
            containerView.addSubview(fromImageView)
            toView.frame = CGRect(origin: .zero, size: containerView.bounds.size)
            toView.alpha = 0
            animationBlock = {
                toView.alpha = 1
                fromImageView.alpha = 0
                updateFrameClosure()
            }
            completionBlock = { _ in
                let success = !transitionContext.transitionWasCancelled
                if !success {
                    toView.removeFromSuperview()
                }
                cleanupClosure()
                transitionContext.completeTransition(success)
            }
        } else {
            guard let fromView = transitionContext.view(forKey: .from) else {
                transitionContext.completeTransition(false)
                assertionFailure()
                return
            }
            containerView.addSubview(toImageView)
            containerView.addSubview(fromImageView)
            animationBlock = {
                fromView.alpha = 0
                fromImageView.alpha = 0
                updateFrameClosure()
            }
            completionBlock = { _ in
                let success = !transitionContext.transitionWasCancelled
                if success {
                    fromView.removeFromSuperview()
                }
                cleanupClosure()
                transitionContext.completeTransition(success)
            }
        }

        UIView.animate(
            withDuration: transitionDuration,
            delay: 0,
            options: isPresenting ? .curveEaseIn : .curveEaseOut,
            animations: animationBlock,
            completion: completionBlock
        )
    }
}

extension UIView {
    func frame(in view: UIView?) -> CGRect {
        if let superview = superview {
            return superview.convert(frame, to: view)
        }
        return frame
    }
}

extension UIView {
    func snapshot(scale: CGFloat = 0, isOpaque: Bool = false) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)

        let snapshot = renderer.image(actions: { context in
            layer.render(in: context.cgContext)
        })
        
        return snapshot
    }
}
