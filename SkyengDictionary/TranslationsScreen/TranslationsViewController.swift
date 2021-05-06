//
//  TranslationsViewController.swift
//  SkyengDictionary
//
//  Created by Екатерина Батеева on 11.04.2021.
//

import UIKit

class TranslationsViewController: UIViewController {
    var viewModel = TranslationsViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MeaningCell.self, forCellReuseIdentifier: "meaningCell")
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        layoutSubview()
    }
    
    // MARK: Private
    
    private func layoutSubview() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

// MARK: UITableViewDelegate, UITableViewDataSource

extension TranslationsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.meanings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let selectedRow = viewModel.selectedRow,
           selectedRow == indexPath.row {
            let url = viewModel.meanings[indexPath.row].imageUrl ?? ""
            let image = viewModel.getImageFrom(urlString: url)
            return (image?.size.height ?? 0) * 0.5 + 64
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let selectedRow = viewModel.selectedRow,
           selectedRow == indexPath.row {
            let text = viewModel.meanings[indexPath.row].translation.text
            let url = viewModel.meanings[indexPath.row].imageUrl ?? ""
            let image = viewModel.getImageFrom(urlString: url)
            let model = MeaningViewModel(text: text, image: image)
            let cell = MeaningCell(model: model)
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = viewModel.meanings[indexPath.row].translation.text
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var involvedRows: [IndexPath] = [indexPath]
        if let selectedRow = viewModel.selectedRow {
            let oldIndexPath = IndexPath(row: selectedRow, section: 0)
            involvedRows.append(oldIndexPath)
        }
        
        viewModel.selectedRow = indexPath.row
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: involvedRows, with: .fade)
    }
}
