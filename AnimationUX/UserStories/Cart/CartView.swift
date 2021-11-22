import UIKit

class CartView: UIView {

    // MARK: - Properties

    let tableView = UITableView()
    let nextButton = UIButton()

    // MARK: - Methods

    func configure() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 0, left: 0, bottom: 72, right: 0)
        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 100
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        addSubview(nextButton)
        nextButton.layer.cornerRadius = 10
        nextButton.layer.masksToBounds = true
        nextButton.setTitleColor(.systemBackground, for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        nextButton.setBackgroundImage(UIImage(color: .systemGreen, size: .init(side: 1)), for: .normal)
        nextButton.setBackgroundImage(UIImage(color: .systemGreen.withAlphaComponent(0.7), size: .init(side: 1)), for: .highlighted)
        nextButton.setBackgroundImage(UIImage(color: .systemGreen.withAlphaComponent(0.5), size: .init(side: 1)), for: .disabled)
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin).inset(16)
        }
        
    }

}
