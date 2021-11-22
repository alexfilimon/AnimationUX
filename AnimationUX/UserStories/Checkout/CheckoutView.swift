import UIKit

class CheckoutView: UIView {

    // MARK: - Properties

    let nextButton = UIButton()
    let messageLabel = UILabel()

    // MARK: - Methods

    func configure() {
        backgroundColor = .systemBackground

        addSubview(nextButton)
        nextButton.layer.cornerRadius = 10
        nextButton.layer.masksToBounds = true
        nextButton.setTitleColor(.systemBackground, for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        nextButton.setBackgroundImage(UIImage(color: .systemGreen, size: .init(side: 1)), for: .normal)
        nextButton.setBackgroundImage(UIImage(color: .systemGreen.withAlphaComponent(0.7), size: .init(side: 1)), for: .highlighted)
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin).inset(16)
        }
        nextButton.setTitle("Оформить заказ")

        addSubview(messageLabel)
        messageLabel.text = "Здесь будет оформление заказа"
        messageLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        messageLabel.textColor = .label
        messageLabel.numberOfLines = 0
        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(32)
        }
    }

}
