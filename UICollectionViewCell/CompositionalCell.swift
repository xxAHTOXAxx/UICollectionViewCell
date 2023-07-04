import UIKit

class CompositionalCell: UICollectionViewCell {
    
    static let identifier = "CompositionalCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("ERROR")
    }
}
