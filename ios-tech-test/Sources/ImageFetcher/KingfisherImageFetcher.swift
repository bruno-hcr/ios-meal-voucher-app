import ImageFetcherInterface
import Kingfisher
import UIKit

final class KingfisherImageFetcher: ImageFetcherProtocol {
    func fetchImage(with url: URL, imageView: UIImageView) {
        imageView.kf.setImage(with: url)
    }
}
