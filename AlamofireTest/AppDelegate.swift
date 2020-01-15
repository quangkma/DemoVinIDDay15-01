
//  AppDelegate.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.

import UIKit

@UIApplicationMain
@available(iOS 13.0, *)
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *){
            
        }else{
            window = UIWindow(frame: UIScreen.main.bounds)
            let token = UserDefaults.standard.string(forKey: "token") ?? ""
            if token.isEmpty {
                startLogin()
            }else{
                startMain()
            }
        }
        return true
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
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}

