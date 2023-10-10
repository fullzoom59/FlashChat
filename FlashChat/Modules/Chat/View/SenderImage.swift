import UIKit

class SenderImage: UIImageView {
    override init(image: UIImage?) {
        super.init(frame: .zero)
        self.image = image
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
