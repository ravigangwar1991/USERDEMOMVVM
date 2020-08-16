//
//  UserListTableViewCell.swift
//  User Demo
//
//  Created by Ravi on 15/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    //MARK:================IBOUTLETS==========================
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var companyNameTitleLabel: UILabel!
    @IBOutlet weak var phoneWebsiteLabel: UILabel!
    @IBOutlet weak var phoneWebsiteTitleLabel: UILabel!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    //MARK:================PROPERTIES==========================
    
    var favBtnTaaped: (() -> Void)?
    
    var userItem: UserModel? {
        
        didSet {
            
            self.setData()
        }
    }
    
    //MARK:================TABLEVIEW LIFE CYCLE==========================
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.prepareUI()
    }
    
    //MARK:================ CUSTOM METHOD==========================
    
    func prepareUI(){
        self.nameTitleLabel.text = "Name:"
        self.phoneWebsiteTitleLabel.text = "Phone & Website:"
        self.companyNameTitleLabel.text = "Company Name:"
    }
    
    func setData(){
        
        guard let user = userItem else {return}
        self.nameLabel.text = user.name
        self.phoneWebsiteLabel.text = (user.phone ?? "") + " & " + (user.website ?? "")
        self.companyLabel.text = user.company?.name
        self.starButton.isSelected = user.isFav
        
    }
    
    //MARK:================IBACTIONS==========================
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.userItem?.isFav = sender.isSelected
        self.setData()
        self.favBtnTaaped?()
    }
}
