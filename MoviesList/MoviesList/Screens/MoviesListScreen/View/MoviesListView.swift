//
//  MoviesListView.swift
//  MoviesList
//
//  Created by DiOS on 02.09.2022.
//

import UIKit
import SnapKit

class MoviesListView: UIView {
    var code: String? {
        return moviesYearTextField.text
    }
    
    let moviesTitleTextField: TextFieldWithPadding = {
        let obj = TextFieldWithPadding()
        obj.placeholder = "Title"
        obj.layer.borderWidth = 1
        obj.layer.cornerRadius = 10
        obj.layer.borderColor = UIColor.systemGray5.cgColor
        obj.textPadding = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        return obj
    }()
    
    let moviesYearTextField: TextFieldWithPadding = {
        let obj = TextFieldWithPadding()
        obj.placeholder = "Year"
        obj.keyboardType = .numberPad
        obj.layer.borderWidth = 1
        obj.layer.cornerRadius = 10
        obj.layer.borderColor = UIColor.systemGray5.cgColor
        obj.textPadding = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        return obj
    }()
    
    let addButton: UIButton = {
        let obj = UIButton()
        obj.layer.cornerRadius = 10
        obj.setTitle("Add", for: .normal)
        obj.backgroundColor = .systemBlue
        return obj
    }()
    
    let tableView: UITableView = {
        let obj = UITableView()
        obj.rowHeight = UITableView.automaticDimension
        obj.separatorStyle = .none
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        addSubview(moviesTitleTextField)
        addSubview(moviesYearTextField)
        addSubview(addButton)
        addSubview(tableView)
        
        moviesTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(50)
        }
        moviesYearTextField.snp.makeConstraints { make in
            make.top.equalTo(moviesTitleTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(moviesTitleTextField)
        }
        addButton.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(moviesYearTextField.snp.bottom).offset(8)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(addButton.snp.bottom).offset(24)
        }
    }
}
