//
//  TaskTableViewCell.swift
//  CustomHorizontalCalendar
//
//  Created by Bayram Yeleç on 22.01.2025.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    static let identifier: String = "TaskTableViewCell"
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let taskLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let taskImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle.fill")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(backView)
        backView.addSubview(taskLabel)
        backView.addSubview(taskDescriptionLabel)
        backView.addSubview(taskImageView)
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        taskImageView.translatesAutoresizingMaskIntoConstraints = false
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        taskLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(20)
        }
        taskDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(taskLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
        taskImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
            make.width.height.equalTo(20)
            make.left.equalTo(taskLabel.snp.right).offset(10)
            make.left.equalTo(taskDescriptionLabel.snp.right).offset(10)
        }
        
    }
    
}
