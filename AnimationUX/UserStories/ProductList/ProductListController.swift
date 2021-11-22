import UIKit

class ProductListController: UIViewController {

    // MARK: - Private Properties

    private lazy var adapter = ProductListAdapter(collectionView: mainView.collectionView)

    private let mainView = ProductListView()

    // MARK: - Properties

    var onAddProduct: ((UIImageView, ProductModel) -> Void)?

    // MARK: - UIViewController

    override func loadView() {
        view = mainView
        mainView.configure()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        adapter.onProductToCart = { [weak self] image, view, product in
            let realFrame = self?.mainView.collectionView.convert(view.frame, to: self?.view)
            let imageView = UIImageView(image: image)
            imageView.frame = realFrame ?? .zero
            self?.onAddProduct?(imageView, product)
        }
        let items = ProductsDataProvider.getItems()
        adapter.configure(items: items)
    }

}
