//
//  UserListVC.swift
//  User Demo
//
//  Created by Ravi on 14/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import UIKit

class UserListVC: BaseVC {
    
    //MARK:================IBOUTLETS==========================
    
    @IBOutlet weak var userListTV: UITableView!
    
    //MARK:================PROPERTIES==========================
    var viewModel = UserListVM()
    
    //MARK:================VIEWCONTROLLER LIFE CYCLE==========================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.prepareUI()
    }
    
}

//MARK:================EXTENSION CUSTOM METHOD==========================

extension UserListVC {
    
    func prepareTableView() {
        
        self.userListTV.separatorStyle   = .singleLine
        self.userListTV.estimatedRowHeight = 160
        self.userListTV.rowHeight = UITableView.automaticDimension
        self.userListTV.delegate = self
        self.userListTV.dataSource = self
        
    }
    
    func prepareUI(){
        
        self.prepareTableView()
        self.fetchUserList()
        prepareViewModelObserver()
    }
    
    func fetchUserList() {
        viewModel.fetchUserList(view: self.view)
        
    }
    
    func prepareViewModelObserver() {
        self.viewModel.reloadView = {[weak self] in
            guard let self = self else {return}
            self.reloadTableView()
        }
    }
    
    func reloadTableView() {
        self.userListTV.reloadData()
    }
}


//MARK:================ UITableView Delegate And Datasource Methods==========================

extension UserListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath as IndexPath) as? UserListTableViewCell else {
            fatalError("UserListTableViewCell cell is not found")
        }
        
        cell.favBtnTaaped = {[weak self] in
            guard let self = self else {return}
            self.viewModel.updateFavStatus(index: indexPath.row)
        }
        
        let user = viewModel.getUser(index:indexPath.row)
        cell.userItem = user
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsScene = UserDetailsVC.instantiate(fromAppStoryboard: .Main)
        detailsScene.completion = {[weak self] (index,userData) in
            guard let self = self else {return}
            guard let user = userData else {return}
            self.viewModel.updateDataAtIndex(index: index, user: user)
        }
        let user = viewModel.getUser(index:indexPath.row)
        detailsScene.viewModel.setUserData(index:indexPath.row,user: user)
        self.navigationController?.pushViewController(detailsScene, animated: true)
    }
}
