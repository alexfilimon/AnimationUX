struct CartModel {

    // MARK: - Properties

    let items: [CartItemModel]

    // MARK: - Computed Properties

    var wholeSum: Double {
        return items.reduce(0) { partialResult, cartModel in
            return partialResult + cartModel.product.price * Double(cartModel.count)
        }
    }

    var wholeProductCount: Int {
        return items.map { $0.count }.reduce(0, +)
    }

}
