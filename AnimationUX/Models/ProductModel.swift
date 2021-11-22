import Foundation

struct ProductModel: Equatable {
    let id: UUID
    let title: String
    let price: Double
    let imageURLString: String
    let isFav: Bool
}
