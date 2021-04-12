//
//  ViewController.swift
//  SkyengDictionary
//
//  Created by Екатерина Батеева on 10.04.2021.
//

import UIKit

class SearchViewController: UIViewController {
    let viewModel = SearchViewModel()
    
    private lazy var searchField: UISearchTextField = {
        let searchField = UISearchTextField()
        searchField.placeholder = "Введите слово"
        return searchField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        searchField.delegate = self

        title = "Поиск слова"
        view.backgroundColor = .white
        layoutSubview()
    }
    
    // MARK: Private
    
    private func layoutSubview() {
        view.addSubview(searchField)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

// MARK: SearchViewModelDelegate

extension SearchViewController: SearchViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: UISearchTextFieldDelegate

extension SearchViewController: UISearchTextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            viewModel.searchValue = updatedText
        }
        return true
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource 

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.translations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if viewModel.words.count > indexPath.row {
            cell.textLabel?.text = viewModel.words[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWord = viewModel.words[indexPath.row]
        let meanings = viewModel.getMeanings(for: selectedWord)
        
        let controller = TranslationsViewController()
        controller.viewModel.meanings = meanings
        controller.title = selectedWord
        self.navigationController?.pushViewController(controller, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
