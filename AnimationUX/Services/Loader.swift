import UIKit

class Loader {

    // MARK: - Static Properties

    static let shared = Loader()

    // MARK: - Methods

    func show() {
        let loaderView = LoaderView()
        loaderView.frame = UIScreen.main.bounds
        getRootWindow()?.addSubview(loaderView)
    }

    func hide() {
        let first = getRootWindow()?.subviews.first(where: { $0 is LoaderView })
        first?.removeFromSuperview()
    }

    // MARK: - Private Methods

    private func getRootWindow() -> UIWindow? {
        return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
    }

}

class LoaderView: UIView {

    private let activityIndicatorView = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.sizeToFit()
        activityIndicatorView.center = .init(x: frame.width / 2, y: frame.height / 2)
    }

    func commonInit() {
        self.backgroundColor = .black.withAlphaComponent(0.5)
        addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }

}
