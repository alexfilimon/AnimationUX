import UIKit
import SparrowKit
import SnapKit

class CartItemTableCell: UITableViewCell {

    // MARK: - Subviews

    private let productImageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let numberOfItemsLabel = UILabel()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: - Methods

    func configure(item: CartItemModel) {
        productImageView.download(from: URL(string: item.product.imageURLString)!, contentMode: .scaleAspectFill)

        titleLabel.text = item.product.title

        priceLabel.text = NumberFormatter.rubNumberFormatter.string(from: item.product.price as NSNumber)

        numberOfItemsLabel.text = "Кол-во: \(item.count)"
    }

    // MARK: - Appearance

    private func commonInit() {
        selectionStyle = .none

        contentView.addSubview(productImageView)
        productImageView.layer.cornerRadius = 10
        productImageView.layer.masksToBounds = true
        productImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(16)
            make.height.equalTo(productImageView.snp.width)
        }

        contentView.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .left
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }

        contentView.addSubview(numberOfItemsLabel)
        numberOfItemsLabel.font = .systemFont(ofSize: 14, weight: .regular)
        numberOfItemsLabel.textColor = .secondaryLabel
        numberOfItemsLabel.textAlignment = .right
        numberOfItemsLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }

        contentView.addSubview(priceLabel)
        priceLabel.font = .systemFont(ofSize: 14, weight: .bold)
        priceLabel.textColor = .label
        priceLabel.textAlignment = .right
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
            make.top.equalTo(numberOfItemsLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }

    }

}
