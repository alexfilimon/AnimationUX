import UIKit
import SPAlert

class ProductListAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Private Properties

    private weak var collectionView: UICollectionView?
    private var items: [ProductModel] = []

    // MARK: - Properties

    var onProductToCart: ((ProductModel) -> Void)?

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
                let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
                window?.isUserInteractionEnabled = false
                SPAlert.present(title: "Добавлено", message: "Товар добавлен в избранное", preset: .heart, completion: { [weak window] in
                    window?.isUserInteractionEnabled = true
                })
                self?.items[indexPath.row] = .init(
                    id: item.id,
                    title: item.title,
                    price: item.price,
                    imageURLString: item.imageURLString,
                    isFav: isFav
                )
            },
            onButtonPress: { [weak self] in
                self?.onProductToCart?(item)
            }
        )
        return cell
    }

    // MARK: - UICollectionViewDelegate

}
