import Combine
import UIKit

class CartService {

    // MARK: - Properties

    @Published var cartModel = CartModel(items: [])

    var cartTabBarItem: UITabBarItem?

    // MARK: - Private Properties

    private var cancellable: Cancellable?

    // MARK: - Static Properties

    static let shared = CartService()

    // MARK: - Initialization

    private init() {
        cancellable = $cartModel.sink(receiveValue: { [weak self] model in
            let count = model.wholeProductCount
            self?.cartTabBarItem?.badgeValue = count > 0 ? String(count) : nil
        })
    }

    // MARK: - Methods

    func removeProduct(_ product: ProductModel) {
        guard let index = cartModel.items.firstIndex(where: { $0.product.id == product.id }) else {
            return
        }
        var oldItems = cartModel.items
        oldItems.remove(at: index)
        cartModel = CartModel(items: oldItems)
    }

    func addProduct(_ product: ProductModel) {
        if let alreadyExistCartItemIndex = cartModel.items.firstIndex(where: { $0.product.id == product.id }) {
            var oldItems = cartModel.items
            oldItems[alreadyExistCartItemIndex] = CartItemModel(
                product: oldItems[alreadyExistCartItemIndex].product,
                count: oldItems[alreadyExistCartItemIndex].count + 1
            )
            cartModel = .init(items: oldItems)
            return
        }

        let newCartItem = CartItemModel(
            product: product,
            count: 1
        )
        let oldItems = cartModel.items
        cartModel = .init(items: oldItems + [newCartItem])
    }

    func removeAll() {
        cartModel = .init(items: [])
    }
}
