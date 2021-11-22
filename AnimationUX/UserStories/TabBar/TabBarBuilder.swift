import UIKit

extension UITabBar {

    func getFrameForTabAt(index: Int) -> CGRect? {
        var frames = self.subviews.compactMap { return $0 is UIControl ? $0.frame : nil }
        frames.sort { $0.origin.x < $1.origin.x }
        return frames[safe: index]
    }

}

extension Collection {

    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

}

class TabBarBuilder {

    func build() -> UITabBarController {
        let tabBarController = UITabBarController()

        let productListController = ProductListController()
        let productListNavigationController = UINavigationController(rootViewController: productListController)
        productListNavigationController.navigationBar.prefersLargeTitles = true
        productListController.tabBarItem = UITabBarItem(
            title: "Продукты",
            image: UIImage(systemName: "list.bullet"),
            selectedImage: nil
        )
        productListController.navigationItem.title = "Продукты"
        productListController.navigationItem.largeTitleDisplayMode = .always

        let cartController = CartController()
        let cartNavigationController = UINavigationController(rootViewController: cartController)
        cartNavigationController.navigationBar.prefersLargeTitles = true
        cartController.tabBarItem = UITabBarItem(
            title: "Корзина",
            image: UIImage(systemName: "cart"),
            selectedImage: UIImage(systemName: "cart.fill")
        )
        cartController.navigationItem.title = "Корзина"
        cartController.navigationItem.largeTitleDisplayMode = .always
        CartService.shared.cartTabBarItem = cartController.tabBarItem

        productListController.onAddProduct = { product in
            CartService.shared.addProduct(product)
        }

        tabBarController.viewControllers = [
            productListNavigationController,
            cartNavigationController
        ]

        tabBarController.selectedViewController = productListNavigationController

        return tabBarController
    }

}
