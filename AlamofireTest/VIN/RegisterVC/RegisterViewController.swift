
//  RegisterVCViewController.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.

import UIKit
import AlamofireObjectMapper
import Alamofire

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pwConfirmTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onRegister(_ sender: Any) {
        guard let phoneNumber  = phoneTextField.text, !phoneNumber.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        guard let confirmpassword =  pwConfirmTf.text, !confirmpassword.isEmpty else { return }
        
        let params = [
            "phone_number": phoneNumber,
            "password": password,
            "confirm_password": confirmpassword
                        ]
        
        let url = "http://45.118.145.149:8100/register"
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { [weak self] (response: DataResponse<APIRegister>) in
            guard let _ = self, let res = response.result.value else { return }
            if res.code == 1001 {
                print(res.message ?? 0)
            }else{
                print("Dang ky thanh cong")
            }
        }
    }
    
    @IBAction func backLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    } 
}
