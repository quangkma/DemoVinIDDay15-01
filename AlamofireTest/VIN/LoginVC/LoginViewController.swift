
//  LoginVCViewController.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.

import UIKit
import  Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var tfMail : UITextField!
    @IBOutlet private weak var tfPass : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    }

    @IBAction private func handleTouchBtn() {
        
        guard let phone = tfMail.text, !phone.isEmpty else { return }
        guard let password = tfPass.text, !password.isEmpty else { return }
        
        let params = [
            "phone_number": phone,
            "password": password
                      ]
        
        let url = "http://34.80.70.61/api/login"
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { [weak self] (response: DataResponse<APILogin>) in
            guard let strongSelf = self, let res = response.result.value else { return }
            let token = res.token
            UserDefaults.standard.set(token, forKey: "token")
            let homeVC = MainVCViewController()
            let navigation = UINavigationController(rootViewController: homeVC)
            navigation.modalPresentationStyle = .fullScreen
            strongSelf.present(navigation, animated: true, completion: nil)
        }
    }
    
    @IBAction private func handleTouhRegisterBtn() {
        let registerVC = RegisterViewController()
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true, completion: nil)
    }
}
