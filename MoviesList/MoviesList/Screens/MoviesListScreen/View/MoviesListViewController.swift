//
//  MoviesListViewController.swift
//  MoviesList
//
//  Created by DiOS on 02.09.2022.
//

import UIKit

class MoviesLisViewController: UIViewController {
    let mainView = MoviesListView()
    var moviesData: [MoviesListModel] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        mainView.moviesTitleTextField.delegate = self
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MoviesListTableViewCell.self, forCellReuseIdentifier: MoviesListTableViewCell.id)
        
        mainView.addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    static func filterDuplicate(lhs: MoviesListModel, rhs: MoviesListModel) -> Bool {
        return lhs.title == rhs.title
    }
    
    @objc private func didTapAddButton() {
        dataReceiver()
    }
    
    func dataReceiver() {
        guard let code = mainView.code else { return }

        if mainView.moviesTitleTextField.text == "" || mainView.moviesYearTextField.text == "" {
            let alert = UIAlertController(title: "Ooops", message: "Enter all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            if mainView.moviesTitleTextField.text == "" {
                mainView.moviesTitleTextField.becomeFirstResponder()
            } else {
                mainView.moviesYearTextField.becomeFirstResponder()
            }
            navigationController?.present(alert, animated: true, completion: nil)
        } else {
            if code.count != 4 {
                let alert = UIAlertController(title: "Ooops", message: "Enter correct year YYYY", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                if mainView.moviesTitleTextField.text == "" {
                    mainView.moviesTitleTextField.becomeFirstResponder()
                } else {
                    mainView.moviesYearTextField.becomeFirstResponder()
                }
                navigationController?.present(alert, animated: true, completion: nil)
            } else {
                
                guard let title = mainView.moviesTitleTextField.text,
                      let year = mainView.moviesYearTextField.text
                else { return }
                
                let model = MoviesListModel(title: title, year: year)
                
                if moviesData.contains(model) {
                    let alert = UIAlertController(title: "This movie is already on the list", message: "Duplicate movies will be deleted", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    navigationController?.present(alert, animated: true, completion: nil)
                } else {
                    moviesData.insert(model, at: 0)
                    mainView.tableView.reloadData()
                    mainView.moviesTitleTextField.text = ""
                    mainView.moviesYearTextField.text = ""
                    mainView.moviesTitleTextField.resignFirstResponder()
                    mainView.moviesYearTextField.resignFirstResponder()
                }
            }
        }
    }
}
//MARK: - TableView DELEGATE & DATASOURCE
extension MoviesLisViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesListTableViewCell.id) as? MoviesListTableViewCell else { return UITableViewCell() }
        let data = moviesData[indexPath.row]
        cell.model = data
        return cell
    }
}
//MARK: - TextField DELEGATE
extension MoviesLisViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mainView.moviesYearTextField.becomeFirstResponder()
        return true
    }
}
