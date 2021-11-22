import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.tintColor = .systemGreen
        let splash = SplashController()
        splash.onEndAnimation = { [weak self] in
            self?.window?.rootViewController = TabBarBuilder().build()
            self?.window?.makeKeyAndVisible()
        }
        window?.rootViewController = splash
        window?.makeKeyAndVisible()
    }

}

