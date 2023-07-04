import UIKit

class CompositionalView: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CompositionalCell.self, forCellWithReuseIdentifier: CompositionalCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        title = "Simple Example"
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension CompositionalView: UICollectionViewDataSource, UICollectionViewDelegate {
    //    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //        let item = collectionView.dequeueReusableCell(withReuseIdentifier: CompositionalCell.identifier, for: indexPath)
    //        item.backgroundColor = .systemGreen
    //        return item
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_collection: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 20
        case 1:
            return 10
        default:
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CompositionalCell.identifier,for: indexPath)
            cell.backgroundColor = .systemGreen
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompositionalCell.identifier, for: indexPath)
            cell.backgroundColor = .systemBlue
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompositionalCell.identifier, for: indexPath)
            cell.backgroundColor = .systemRed
            return cell
        }
    }
    
}

extension CompositionalView: UICollectionViewDelegateFlowLayout {
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        5
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        5
    //    }

    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            switch sectionIndex {
            case 0:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 2.2),
                                                       heightDimension: .fractionalHeight(1 / 1.8 * 2))
                let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                                   subitem: layoutItem, count: 5)
                layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
                
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                layoutSection.orthogonalScrollingBehavior = .groupPaging
                
                return layoutSection
                
            case 1:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(44))
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                   subitems: [layoutItem])
               // layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
                
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 10, bottom: 50, trailing: 10)
                
                return layoutSection
                
            default:
                
                let firstItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight (1))
                let firstLayoutItem = NSCollectionLayoutItem (layoutSize: firstItemSize)
                firstLayoutItem.contentInsets = NSDirectionalEdgeInsets (top: 5, leading: 5, bottom: 5, trailing: 5)
                let secondItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight (0.5))
                let secondLayoutItem = NSCollectionLayoutItem(layoutSize: secondItemSize)
                secondLayoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let rightGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth (0.4),
                heightDimension: .fractionalHeight (1))
                let rightLayoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: rightGroupSize, subitem: secondLayoutItem, count: 2)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth (1), heightDimension: .estimated (500))
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [firstLayoutItem, rightLayoutGroup])
                layoutGroup.contentInsets = NSDirectionalEdgeInsets (top: 0, leading: 0, bottom: 0, trailing: 20)
                let layoutSection = NSCollectionLayoutSection (group: layoutGroup)
                layoutSection.contentInsets = NSDirectionalEdgeInsets (top: 0, leading: 10, bottom: 0, trailing: 10)
                layoutSection.orthogonalScrollingBehavior = .groupPaging
                return layoutSection
            }
        }
    }
}



