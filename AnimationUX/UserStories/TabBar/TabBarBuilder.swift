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

        productListController.onAddProduct = { [weak tabBarController, weak cartNavigationController] view, product in
            tabBarController?.view.addSubview(view)
            let index = tabBarController?.viewControllers?.firstIndex(where: { $0 === cartNavigationController }) ?? 0
            let frameTab = tabBarController?.tabBar.getFrameForTabAt(index: index) ?? .zero
            let convertedFrameTab = tabBarController?.tabBar.convert(frameTab, to: tabBarController?.view) ?? .zero
            UIView.animate(withDuration: [0.3, 0.4, 0.5].randomElement()!, animations: {
                view.center = .init(x: convertedFrameTab.midX, y: convertedFrameTab.midY)
                let sign = [CGFloat(-1), CGFloat(1)].randomElement()!
                let angle = .pi / CGFloat((3...8).randomElement()!)
                view.transform = .init(scale: 0.2).concatenating(.init(rotationAngle: sign * angle))
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = 0
                }, completion: { _ in
                    CartService.shared.addProduct(product)
                    view.removeFromSuperview()
                })
            })
        }

        tabBarController.viewControllers = [
            productListNavigationController,
            cartNavigationController
        ]

        tabBarController.selectedViewController = productListNavigationController

        return tabBarController
    }

}
