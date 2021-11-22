import UIKit

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Loader.shared.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            Loader.shared.hide()
        }
    }

    // MARK: - Actions

    @objc
    private func handleButtonPress() {
        dismiss(animated: true, completion: nil)
        CartService.shared.removeAll()
    }

}
