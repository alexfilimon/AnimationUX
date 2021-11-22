import SparrowKit
import UIKit

class SplashController: SPController {

    // MARK: - Private Properties

    private let mainView = SplashView()

    // MARK: - Properties

    var onEndAnimation: (() -> Void)?

    // MARK: - UIViewController

    override func loadView() {
        view = mainView
        mainView.configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.onEndAnimation?()
        }
    }

}
