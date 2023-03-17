import UIKit

public protocol ImageFetcherProtocol {
    func fetchImage(with url: URL, imageView: UIImageView)
}
