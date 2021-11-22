import UIKit
import SparrowKit

class ProductListCollectionCell: UICollectionViewCell {

    // MARK: - Subviews

    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let button = UIButton()
    private let productImageView = UIImageView()
    private let favButton = UIButton()

    // MARK: - Private Properties

    private var onButtonPress: (() -> Void)?
    private var onFavPress: ((Bool) -> Void)?
    private var isFav = false

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: - UICollectionView

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.transform = self.isHighlighted ? .init(scale: 0.97) : .identity
            }
        }
    }

    // MARK: - Methods

    func configure(
        title: String,
        price: Double,
        productImageURL: URL,
        isFav: Bool,
        onFavPress: @escaping (Bool) -> Void,
        onButtonPress: @escaping () -> Void
    ) {
        titleLabel.text = title
        priceLabel.text = NumberFormatter.rubNumberFormatter.string(from: price as NSNumber)
        productImageView.download(from: productImageURL, contentMode: .scaleAspectFill)
        self.onButtonPress = onButtonPress

        setFav(isFav, animated: false)
        self.onFavPress = onFavPress
    }

    // MARK: - Appearance

    private func commonInit() {
        contentView.addSubview(productImageView)
        productImageView.layer.cornerRadius = 10
        productImageView.layer.masksToBounds = true
        productImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(180)
        }

        contentView.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(productImageView.snp.bottom).offset(10)
        }

        contentView.addSubview(priceLabel)
        priceLabel.font = .systemFont(ofSize: 12, weight: .regular)
        priceLabel.textColor = .label
        priceLabel.textAlignment = .center
        priceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom)
        }

        contentView.addSubview(button)
        button.addTarget(self, action: #selector(handleButtonPress), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("В корзину", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setBackgroundImage(UIImage(color: .systemGreen, size: .init(side: 1)), for: .normal)
        button.setBackgroundImage(UIImage(color: .systemGreen.withAlphaComponent(0.7), size: .init(side: 1)), for: .highlighted)
        button.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(35)
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
        }

        contentView.addSubview(favButton)
        favButton.addTarget(self, action: #selector(favButtonPress), for: .touchUpInside)
        favButton.tintColor = .systemGreen
        favButton.snp.makeConstraints { make in
            make.size.equalTo(44)
            make.top.trailing.equalToSuperview()
        }
    }

    // MARK: - Private Methods

    private func setFav(_ isFav: Bool, animated: Bool) {
        self.isFav = isFav
        let animationImageBlock: () -> Void = {
            self.favButton.setImage(UIImage(systemName: isFav ? "heart.fill" : "heart"))
            self.favButton.tintColor = isFav ? .systemRed : .systemGreen
        }
        let animationTransformBlock1: () -> Void = {
            self.favButton.transform = .init(scale: 1.2)
        }
        let animationTransformBlock2: () -> Void = {
            self.favButton.transform = .identity
        }
        if animated {
            UIView.transition(
                with: favButton,
                duration: 0.1,
                options: .transitionCrossDissolve,
                animations: animationImageBlock
            ) { _ in
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: [.curveEaseInOut],
                    animations: animationTransformBlock1,
                    completion: { _ in
                        UIView.animate(
                            withDuration: 0.2,
                            delay: 0,
                            options: [.curveEaseInOut],
                            animations: animationTransformBlock2,
                            completion: nil
                        )
                    }
                )
            }
        } else {
            animationImageBlock()
            animationTransformBlock2()
        }
    }

    // MARK: - Actions

    @objc
    private func handleButtonPress() {
        onButtonPress?()
    }

    @objc
    private func favButtonPress() {
        setFav(!isFav, animated: true)
        onFavPress?(isFav)
    }

}
