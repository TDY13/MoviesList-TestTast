//
//  MoviesListTableViewCell.swift
//  MoviesList
//
//  Created by DiOS on 02.09.2022.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {
    static let id = String(describing: MoviesListTableViewCell.self)
    
    var model: MoviesListModel? {
        didSet {
            if let model = model {
                moviesTitleLabel.text = model.title
                moviesYearLabel.text = model.year
            }
        }
    }
    
    let moviesTitleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        obj.textAlignment = .center
        obj.numberOfLines = 0
        return obj
    }()
    
    let moviesYearLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        obj.textAlignment = .center
        return obj
    }()
    
    let dividingLineView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .systemGray5
        return obj
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        contentView.addSubview(moviesTitleLabel)
        contentView.addSubview(moviesYearLabel)
        contentView.addSubview(dividingLineView)
        
        moviesTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(6)
            make.trailing.leading.equalToSuperview().inset(8)
        }
        moviesYearLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(moviesTitleLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-6)
        }
        dividingLineView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
