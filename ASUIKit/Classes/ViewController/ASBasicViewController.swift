//
//  ASBasicViewController.swift
//  YYProject
//
//  Created by 章凯华 on 2018/10/25.
//  Copyright © 2018 章凯华. All rights reserved.
//

import UIKit

class ASBasicViewController: UIViewController {

    var navBarStyle:UIBarStyle {
        get {
            return self.navigationController?.navigationBar.barStyle ?? .default
        }
        set {
            self.previousNavBarStyle = self.navigationController?.navigationBar.barStyle ?? .default
            self.navigationController?.navigationBar.barStyle = newValue
        }
    }
    var navBarTintColor:UIColor {
        get {
            return self.navigationController?.navigationBar.tintColor ?? self.previousNavBarTintColor
        }
        set {
            self.previousNavBarTintColor = self.navigationController?.navigationBar.tintColor ?? self.previousNavBarTintColor
            self.navigationController?.navigationBar.tintColor = newValue
        }
    }
    
    private var previousNavBarStyle:UIBarStyle = .default
    private var previousNavBarTintColor:UIColor = UIColor.blue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        #warning("TODO: click back button navigationBar color")
        self.navigationController?.navigationBar.barStyle = self.navigationController?.navigationBar.barStyle ?? .default
        self.navigationController?.navigationBar.tintColor = self.navigationController?.navigationBar.tintColor
        transitionCoordinator?.animate(alongsideTransition: { [weak self](context) in
            self?.navigationController?.navigationBar.barStyle = self?.previousNavBarStyle ?? .default
            self?.navigationController?.navigationBar.tintColor = self?.previousNavBarTintColor
        }, completion: nil)
    }
}
