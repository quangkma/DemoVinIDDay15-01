
//  SceneDelegate.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let _windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = _windowScene
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        if token.isEmpty {
            startLogin()
        }else{
            startMain()
        }
    }

    func startLogin(){
        let mainVC = LoginViewController()
        
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
    
    func startMain(){
        let mainVC = MainVCViewController()
        
        let navigation = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
      
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
   
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    
    }


}

