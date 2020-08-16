//
//  Global.swift
//  User Demo
//
//  Created by Ravi on 15/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import Foundation
import UIKit

//MARK:================CUSTOM METHOD FOR LOADER==========================

func showActivityLoader(view:UIView) {
    AppLoader.shared.showLoader(view: view)
}

/// Hide Activity Loader
func hideActivityLoader() {
    AppLoader.shared.hideLoader()
}
