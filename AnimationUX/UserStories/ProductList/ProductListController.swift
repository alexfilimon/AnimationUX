import UIKit

class ProductListController: UIViewController {

    // MARK: - Private Properties

    private lazy var adapter = ProductListAdapter(collectionView: mainView.collectionView)

    private let mainView = ProductListView()

    // MARK: - Properties

    var onAddProduct: ((ProductModel) -> Void)?

    // MARK: - UIViewController

    override func loadView() {
        view = mainView
        mainView.configure()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        adapter.onProductToCart = onAddProduct
        let items = ProductsDataProvider.getItems()
        adapter.configure(items: items)
    }

}
