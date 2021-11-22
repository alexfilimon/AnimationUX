import UIKit

class CartAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Private Properties

    private weak var tableView: UITableView?
    private var items: [CartItemModel] = []

    // MARK: - Properties

    var onItemDelete: ((CartItemModel, @escaping (Bool) -> Void) -> Void)?

    // MARK: - Initialization

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartItemTableCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Methods

    func configure(items: [CartItemModel]) {
        self.items = items
        tableView?.reloadData()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartItemTableCell
        cell.configure(item: item)
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = items[indexPath.row]
        let removeAction = UIContextualAction(style: .destructive, title: "Удалить", handler: { [weak self] _, _, completion in
            self?.onItemDelete?(item, completion)
        })
        let config = UISwipeActionsConfiguration(actions: [removeAction])

        return config
    }

}
