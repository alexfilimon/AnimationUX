struct CartItemModel: Hashable {
    let product: ProductModel
    let count: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(count)
        hasher.combine(product.id)
    }
}
