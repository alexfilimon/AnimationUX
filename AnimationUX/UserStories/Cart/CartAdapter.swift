import UIKit

enum Section {
    case main
}

class CartAdapter: NSObject, UITableViewDelegate {

    // MARK: - Private Properties

    private weak var tableView: UITableView?
    private let dataSource: UITableViewDiffableDataSource<Section, CartItemModel>

    // MARK: - Properties

    var onItemDelete: ((CartItemModel, @escaping (Bool) -> Void) -> Void)?

    // MARK: - Initialization

    init(tableView: UITableView) {
        self.tableView = tableView
        self.dataSource = .init(tableView: tableView, cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartItemTableCell
            cell.configure(item: item)
            return cell
        })
        super.init()
        tableView.delegate = self
        tableView.register(CartItemTableCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Methods

    func configure(items: [CartItemModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CartItemModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)

        dataSource.apply(snapshot)
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = dataSource.itemIdentifier(for: indexPath)!
        let removeAction = UIContextualAction(style: .destructive, title: "Удалить", handler: { [weak self] _, _, completion in
            self?.onItemDelete?(item, completion)
        })
        let config = UISwipeActionsConfiguration(actions: [removeAction])

        return config
    }

}
