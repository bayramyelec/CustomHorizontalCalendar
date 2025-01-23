//
//  WeekDaysCollectionViewCell.swift
//  CustomHorizontalCalendar
//
//  Created by Bayram Yeleç on 22.01.2025.
//

import UIKit

class WeekDaysCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "WeekDaysCollectionViewCell"
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let weekDayLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let weekDayLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 20
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(weekDayLabel1)
        stackView.addArrangedSubview(weekDayLabel2)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
}
