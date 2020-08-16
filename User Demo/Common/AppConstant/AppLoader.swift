//
//  AppLoader.swift
//  User Demo
//
//  Created by Ravi on 15/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import UIKit

//MARK:================LOADER==========================

class AppLoader{
    
    static var shared = AppLoader()
    
    var startLoader = false
    var animationView : UIView?
    var loader = UIActivityIndicatorView(style: .whiteLarge)
    
    func showLoader(view:UIView){
        
        if startLoader {return}
        startLoader = true
        animationView = UIView()
        animationView?.backgroundColor = UIColor.black.withAlphaComponent(0.8)
       
        animationView?.frame = view.frame
        animationView?.addSubview(loader)
        loader.center = animationView!.center
        view.addSubview(animationView!)
        loader.startAnimating()

    }
    
    func restartAnimation(){
        if startLoader && animationView != nil{
            loader.startAnimating()
        }
    }
    
    func hideLoader(){
        
        self.startLoader = false
        loader.startAnimating()
        self.animationView?.removeFromSuperview()
       
    }
}
