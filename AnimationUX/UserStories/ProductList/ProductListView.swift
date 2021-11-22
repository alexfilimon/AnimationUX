import UIKit

class ProductListView: UIView {

    // MARK: - Properties

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: - Methods

    func configure() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let screenWidth = UIScreen.main.bounds.width
            let itemsInRow: CGFloat = 2
            let spacing: CGFloat = 10
            let sectionInsets: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
            let availableWidth = screenWidth - sectionInsets.left - sectionInsets.right - max(itemsInRow - 1, 0) * spacing
            layout.itemSize = .init(width: availableWidth / itemsInRow, height: 275)
            layout.scrollDirection = .vertical
            layout.sectionInset = sectionInsets
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
        }

        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
