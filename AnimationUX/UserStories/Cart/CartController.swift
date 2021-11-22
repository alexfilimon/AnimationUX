import UIKit
import Combine

class CartController: UIViewController {

    // MARK: - Private Properties

    private let mainView = CartView()
    private lazy var adapter = CartAdapter(tableView: mainView.tableView)

    private var cancellable: AnyCancellable?

    // MARK: - UIViewController

    override func loadView() {
        view = mainView
        mainView.configure()
        mainView.nextButton.addTarget(self, action: #selector(handleButtonPress), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        adapter.onItemDelete = { [weak self] cartItemModel, completion in
            let alertController = UIAlertController(title: "Удалить", message: "Вы точно хотите удалить '\(cartItemModel.product.title)'", preferredStyle: .actionSheet)

            alertController.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { _ in
                completion(true)
                CartService.shared.removeProduct(cartItemModel.product)
            }))

            alertController.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: { _ in
                completion(false)
            }))

            self?.present(alertController, completion: nil)
        }

        cancellable = CartService.shared.$cartModel.sink { [weak self] newModel in
            self?.adapter.configure(items: newModel.items)
            let numberString = NumberFormatter.rubNumberFormatter.string(from: newModel.wholeSum as NSNumber) ?? ""
            self?.mainView.nextButton.setTitle("Оформить \(numberString)")
            self?.mainView.nextButton.isEnabled = newModel.wholeSum > 0
        }
    }

    // MARK: - Actions

    @objc
    private func handleButtonPress() {
        let controller = CheckoutController()
        let navigationController = UINavigationController(rootViewController: controller)

        present(navigationController, completion: nil)
    }

}
