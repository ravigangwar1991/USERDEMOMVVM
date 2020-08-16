//
//  UserDetailsVC.swift
//  User Demo
//
//  Created by Ravi on 14/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import UIKit

class UserDetailsVC: BaseVC {
    
    //MARK:================IBOUTLETS==========================
    
    @IBOutlet weak var userDetailsTV: UITableView!
    
    //MARK:================PROPERTIES==========================
    
    var viewModel = UserDetailsVM()
    var completion: ((Int,UserModel?) -> Void)?
    
    //MARK:================VIEWCONTROLLER LIFE CYCLE==========================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.prepareUI()
    }
    
}

//MARK:================EXTENSION CUSTOM METHOD==========================

extension UserDetailsVC {
    
    fileprivate func prepareTableView() {
        
        self.userDetailsTV.separatorStyle   = .none
        self.userDetailsTV.estimatedRowHeight = 160
        self.userDetailsTV.rowHeight = UITableView.automaticDimension
        self.userDetailsTV.delegate = self
        self.userDetailsTV.dataSource = self
        
    }
    
    private func prepareUI(){
        
        self.prepareTableView()
        prepareViewModelObserver()
    }
    
    private func prepareViewModelObserver() {
        self.viewModel.reloadView = {[weak self] in
            guard let self = self else {return}
            self.reloadTableView()
        }
    }
    
    private func reloadTableView() {
        self.userDetailsTV.reloadData()
    }
}

//MARK:================UITableView Delegate And Datasource Methods==========================

extension UserDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailsTableViewCell", for: indexPath as IndexPath) as? UserDetailsTableViewCell else {
            fatalError("UserDetailsTableViewCell cell is not found")
        }
        
        cell.favBtnTaaped = {[weak self] in
            guard let self = self else {return}
            self.viewModel.updateFavStatus(index: indexPath.row)
            self.completion?(self.viewModel.selectedIndex,self.viewModel.getUser())
        }
        
        let user = viewModel.getUser()
        cell.userItem = user
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsScene = UserDetailsVC.instantiate(fromAppStoryboard: .Main)
        
        self.navigationController?.pushViewController(detailsScene, animated: true)
    }
}
