import UIKit
import SPConfetti

class CheckoutController: UIViewController {

    // MARK: - Private Properties

    private let mainView = CheckoutView()

    // MARK: - UIViewController

    override func loadView() {
        view = mainView
        mainView.configure()
        mainView.nextButton.addTarget(self, action: #selector(handleButtonPress), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Оформление"
        navigationItem.largeTitleDisplayMode = .always
    }

    // MARK: - Actions

    @objc
    private func handleButtonPress() {
        dismiss(animated: true, completion: nil)
        CartService.shared.removeAll()
        SPConfetti.startAnimating(.fullWidthToDown, particles: [.triangle, .arc, .heart, .star, .circle], duration: 3)
    }

}
