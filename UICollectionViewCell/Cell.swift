import UIKit

class Cell: UICollectionViewCell {
    
    static let identifier = "Сell"
    
    // MARK: - Outlets
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.shadowColor = UIColor.white.cgColor
        image.layer.shadowOpacity = 0.3
        image.layer.shadowOffset = .zero
        image.layer.shadowRadius = 10
        image.layer.rasterizationScale = UIScreen.main.scale
        
        return image
    }()
    
    lazy var percentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var cloudImage: UIImageView = {
        let image = UIImage(systemName: "cloud")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        return imageView
    }()
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    private let bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 90
        return stack
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        addSubview(mainStack)
        mainStack.addArrangedSubview(image)
        mainStack.addArrangedSubview(bottomStack)
        bottomStack.addArrangedSubview(percentLabel)
        bottomStack.addArrangedSubview(cloudImage)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainStack.heightAnchor.constraint(equalToConstant: 300),
            mainStack.widthAnchor.constraint(equalToConstant: 170),
            
            percentLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func prepareForReuse() {
        self.image.image = nil
    }
    
}
