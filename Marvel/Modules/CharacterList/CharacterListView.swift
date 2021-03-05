//
//  CharacterListView.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import UIKit

class CharacterListView: UIViewController {
    
    private let rowHeight: CGFloat = 100
    private let bottomRowsCount = 5
    private let cellIdentifier = "Cell"
    
    var presenter: CharacterListPresenterProtocol!

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = rowHeight
            tableView.register(UINib(nibName: "CharacterListCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewReady()
    }
}

extension CharacterListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CharacterListCell else {
            return UITableViewCell()
        }
        presenter.configure(cell: cell, at: indexPath.row)
        if indexPath.row+1 == presenter.numberOfRows-bottomRowsCount {
            presenter.scrolledToBottom()
        }
        return cell
    }
}

extension CharacterListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.cellTapped(at: indexPath.row)
    }
}

extension CharacterListView: CharacterListViewProtocol {
    
    func display(title: String) {
        self.title = title
    }
    
    func reload() {
        tableView?.reloadData()
    }
}
