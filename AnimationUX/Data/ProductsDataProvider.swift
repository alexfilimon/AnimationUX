import Foundation

enum ProductsDataProvider {

    static func getItems() -> [ProductModel] {
        return [
            .init(
                id: UUID(),
                title: "Microsoft surface",
                price: 40999,
                imageURLString: "https://images.unsplash.com/photo-1633113218833-f0b9912cfe1c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80",
                isFav: false
            ),
            .init(
                id: UUID(),
                title: "Фотоаппарат Sony",
                price: 102999,
                imageURLString: "https://images.unsplash.com/photo-1637497415513-da8ec0ec9a68?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80",
                isFav: false
            ),
            .init(
                id: UUID(),
                title: "Ноутбук Dell",
                price: 39990,
                imageURLString: "https://images.unsplash.com/photo-1593642633279-1796119d5482?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=988&q=80",
                isFav: false
            ),
            .init(
                id: UUID(),
                title: "Замок Disney",
                price: 100_000_000_000,
                imageURLString: "https://images.unsplash.com/photo-1539886075737-7a69d4c28c33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1334&q=80",
                isFav: false
            ),
            .init(
                id: UUID(),
                title: "Воздушный шарик",
                price: 340999,
                imageURLString: "https://images.unsplash.com/photo-1604883781245-0aca44fff711?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80",
                isFav: false
            ),
            .init(
                id: UUID(),
                title: "Ободок с ушками",
                price: 3999,
                imageURLString: "https://images.unsplash.com/photo-1559145829-b0e97dd19467?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80",
                isFav: false
            )
        ]
    }

}
