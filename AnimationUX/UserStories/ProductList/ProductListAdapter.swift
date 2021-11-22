import UIKit

class ProductListAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Private Properties

    private weak var collectionView: UICollectionView?
    private var items: [ProductModel] = []

    // MARK: - Properties

    var onProductToCart: ((UIImage?, UIView, ProductModel) -> Void)?

    // MARK: - Initialization

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(ProductListCollectionCell.self, forCellWithReuseIdentifier: "cell")
    }

    // MARK: - Methods

    func configure(items: [ProductModel]) {
        self.items = items
        collectionView?.reloadData()
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductListCollectionCell
        cell.configure(
            title: item.title,
            price: item.price,
            productImageURL: URL(string: item.imageURLString)!,
            isFav: item.isFav,
            onFavPress: { [weak self] isFav in
                self?.items[indexPath.row] = .init(
                    id: item.id,
                    title: item.title,
                    price: item.price,
                    imageURLString: item.imageURLString,
                    isFav: isFav
                )
            },
            onButtonPress: { [weak self, weak cell] in
                guard let cell = cell else { return }
                let screenshot = cell.screenshot
                self?.onProductToCart?(screenshot, cell, item)
            }
        )
        return cell
    }

    // MARK: - UICollectionViewDelegate

}
