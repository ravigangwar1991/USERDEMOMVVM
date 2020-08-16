//
//  UserDetailsTableViewCell.swift
//  User Demo
//
//  Created by Ravi on 15/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import UIKit

class UserDetailsTableViewCell: UITableViewCell {
    
    //MARK:================IBOUTLETS==========================
    
    @IBOutlet weak var companyDetailsLabel: UILabel!
    @IBOutlet weak var companyDetailsTitleLabel: UILabel!
    @IBOutlet weak var addessDetailLabel: UILabel!
    @IBOutlet weak var addessDetailTitleLabel: UILabel!
    @IBOutlet weak var phoneWebsiteLabel: UILabel!
    @IBOutlet weak var phoneWebsiteTitleLabel: UILabel!
    @IBOutlet weak var userNameTitleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
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
    
    //MARK:================CUSTOM METHOD==========================
    
    func prepareUI(){
        self.nameTitleLabel.text = "Name:"
        self.userNameTitleLabel.text = "Username:"
        self.phoneWebsiteTitleLabel.text = "Phone & Website:"
        self.companyDetailsTitleLabel.text = "Company Detail:"
        self.addessDetailTitleLabel.text = "Address details:"
        
    }
    
    func setData(){
        
        guard let user = userItem else {return}
        
        self.nameLabel.text = user.name
        self.userNameLabel.text = user.username
        self.phoneWebsiteLabel.text = (user.phone ?? "") + " & " + (user.website ?? "")
        self.companyDetailsLabel.text = "Name: \(user.company?.name ?? "")" + "\n" + "CatchPhrase: \(user.company?.catchPhrase ?? "")" + "\n" + "bs: \(user.company?.bs ?? "")"
        self.addessDetailLabel.text = "Street: \(user.address?.street ?? "")" + "\n" + "Suite: \(user.address?.suite ?? "")" + "\n" + "City: \(user.address?.city ?? "")" + "\n" + "Zipcode: \(user.address?.zipcode ?? "")"
        self.starButton.isSelected = user.isFav
        
    }
    
    //MARK:================IBACTION==========================
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.userItem?.isFav = sender.isSelected
        self.favBtnTaaped?()
    }
}
