import UIKit

extension UIImageView {
    public func fetchImage(with url: URL, imageFetcher: ImageFetcherProtocol) {
        imageFetcher.fetchImage(with: url, imageView: self)
    }
}
