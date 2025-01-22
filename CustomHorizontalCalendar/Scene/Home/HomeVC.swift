//
//  HomeVC.swift
//  CustomHorizontalCalendar
//
//  Created by Bayram Yeleç on 21.01.2025.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    private let weekdaysCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeekDaysCollectionViewCell.self, forCellWithReuseIdentifier: WeekDaysCollectionViewCell.identifier)
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let taskTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        tableView.backgroundColor = .black
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .black
        
        view.addSubview(weekdaysCollectionView)
        weekdaysCollectionView.delegate = self
        weekdaysCollectionView.dataSource = self
        weekdaysCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(screenWidth / 5)
        }
        
        view.addSubview(taskTableView)
        taskTableView.delegate = self
        taskTableView.dataSource = self
        taskTableView.snp.makeConstraints { make in
            make.top.equalTo(weekdaysCollectionView.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentWeek.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekDaysCollectionViewCell.identifier, for: indexPath) as! WeekDaysCollectionViewCell
        let date = viewModel.currentWeek[indexPath.row]
        let item1 = viewModel.formattedDate(date: date, format: "dd")
        let item2 = viewModel.formattedDate(date: date, format: "EEE")
        cell.weekDayLabel1.text = item1
        cell.weekDayLabel2.text = item2
        cell.backgroundColor = viewModel.isToday(date: date) ? .white : .black
        cell.weekDayLabel1.textColor = viewModel.isToday(date: date) ? .black : .white
        cell.weekDayLabel2.textColor = viewModel.isToday(date: date) ? .black : .white
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (screenWidth / 8) - 2
        let height = screenWidth / 5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let date = viewModel.currentWeek[indexPath.row]
        viewModel.currentDay = date
        collectionView.reloadData()
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
        cell.textLabel?.text = "deneme"
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        return cell
    }
}
