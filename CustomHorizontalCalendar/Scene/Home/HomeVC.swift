//
//  HomeVC.swift
//  CustomHorizontalCalendar
//
//  Created by Bayram Yeleç on 21.01.2025.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    // MARK: Variables
    
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
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let addTaskButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = UIScreen.main.bounds.width / 12
        button.clipsToBounds = true
        return button
    }()
    
    private let sheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let taskTitle = UITextField()
    let taskDescription = UITextField()
    let taskButton = UIButton()
    let closeButton = UIButton()
    
    var isShow: Bool = false
    
    var viewModel = HomeViewModel()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Funcs
    
    private func setupUI() {
        view.backgroundColor = .black
        
        navigationItem.title = "Today"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
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
            make.top.equalTo(weekdaysCollectionView.snp.bottom).offset(20)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        view.addSubview(addTaskButton)
        addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
        addTaskButton.snp.makeConstraints { make in
            make.width.height.equalTo(screenWidth / 6)
            make.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        view.addSubview(sheetView)
        sheetView.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
        
        setupSheetView()
        
    }
    
    private func setupSheetView(){
        
        let newTaskTitle = UILabel()
        newTaskTitle.text = "New Task"
        newTaskTitle.font = .systemFont(ofSize: 24, weight: .black)
        newTaskTitle.textColor = .black
        
        sheetView.addSubview(newTaskTitle)
        sheetView.addSubview(taskTitle)
        sheetView.addSubview(taskDescription)
        sheetView.addSubview(taskButton)
        sheetView.addSubview(closeButton)
        
        taskTitle.translatesAutoresizingMaskIntoConstraints = false
        taskDescription.translatesAutoresizingMaskIntoConstraints = false
        taskButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.tintColor = .systemRed
        closeButton.setImage(UIImage(systemName: "xmark.app"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        taskTitle.borderStyle = .roundedRect
        taskTitle.placeholder = "Title"
        taskTitle.font = .systemFont(ofSize: 15, weight: .bold)
        
        taskDescription.borderStyle = .roundedRect
        taskDescription.placeholder = "Description"
        taskDescription.font = .systemFont(ofSize: 15, weight: .bold)
        
        taskButton.setTitle("Add", for: .normal)
        taskButton.layer.cornerRadius = 10
        taskButton.backgroundColor = .systemBlue
        taskButton.addTarget(self, action: #selector(taskButtonTapped), for: .touchUpInside)
        
        newTaskTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(10)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        
        taskTitle.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
        }
        taskDescription.snp.makeConstraints { make in
            make.top.equalTo(taskTitle.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
        }
        taskButton.snp.makeConstraints { make in
            make.top.equalTo(taskDescription.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        
    }
    
    @objc func closeButtonTapped(){
        closeSheet()
    }
    
    @objc func taskButtonTapped(){
        guard let taskTitle = taskTitle.text, let taskDescription = taskDescription.text else { return }
        let item = Task(taskTitle: taskTitle, taskDescription: taskDescription, taskDate: Date(), taskColor: UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1))
        viewModel.taskList.append(item)
        viewModel.filteredTasks()
        taskTableView.reloadData()
        self.taskTitle.text = ""
        self.taskDescription.text = ""
        closeSheet()
    }
    
    
    private func closeSheet(){
        isShow = false
        UIView.animate(withDuration: 0.2, animations: {
            if let heightConstraint = self.sheetView.constraints.first(where: { $0.firstAttribute == .height }) {
                heightConstraint.constant = 0
            }
            self.view.layoutIfNeeded()
        })
    }
    
    
    @objc func addTaskButtonTapped(){
        let targetHeight = isShow ? 0 : screenWidth / 1.5 // hedef yüksekliği ayarlıyoruz
        UIView.animate(withDuration: 0.2, animations: {
            if let heightConstraint = self.sheetView.constraints.first(where: { $0.firstAttribute == .height }) {
                heightConstraint.constant = targetHeight
            }
            self.view.layoutIfNeeded()
        })
        isShow.toggle()
    }
    
    
}

// MARK: Collection View

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
        taskTableView.reloadData()
    }
    
}

// MARK: Table View

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
        let item = viewModel.taskList[indexPath.row]
        cell.taskLabel.text = item.taskTitle
        cell.taskDescriptionLabel.text = item.taskDescription
        cell.taskImageView.tintColor = item.taskColor
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.selectionStyle = .none
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: 0, y: -30)
        UIView.animate(withDuration: 0.3, delay: Double(indexPath.row) * 0.2, options: .curveEaseOut, animations: {
            cell.alpha = 1
            cell.transform = .identity
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenWidth / 4
    }
}

