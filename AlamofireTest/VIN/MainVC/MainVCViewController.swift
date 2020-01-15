//
//  MainVCViewController.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved..
//

import UIKit

enum TabBarItem: Int {
    case myHome = 0
    case searchVC
    case myPage
    case listExam

    func getItem() -> (title: CustomLocalizable, icon: String) {
        switch self {
        case .searchVC:
            return (CustomLocalizable.titlepropertySearch, "icon.search")
        case .myHome:
            return (CustomLocalizable.titleBookMyhome, "icon.home")
        case .myPage:
            return (CustomLocalizable.myPage, "icon.human")
        case .listExam:
            return (CustomLocalizable.titlelistExam, "icon.heart")
        }
    }
}

final class MainVCViewController: BaseViewController {
  
    private var tabBarItems: [UITabBarItem] = []
    @IBOutlet private weak var vContainerTabBarVC: UIView!
    
    let tabBarVC = MyTabBarController()
    // using if need.
    var currentSelectedItem = TabBarItem.myHome
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupTabarVC()
        
    }
    
    func changeTabbar(item: TabBarItem, isShowRootView: Bool = false) {
        if let navigation = tabBarVC.viewControllers?[item.rawValue] as? UINavigationController, isShowRootView {
            navigation.popToRootViewController(animated: true)
        }
        currentSelectedItem = item
        tabBarVC.selectedIndex = item.rawValue
    }
    
    
    func topViewController(_ item: TabBarItem) -> UIViewController? {
        guard let navigation = tabBarVC.viewControllers?[item.rawValue] as? UINavigationController else { return nil }
        return navigation.viewControllers.first
    }
    
    func getNavigation(at item: TabBarItem? = nil) -> UINavigationController? {
        let defaultItem = item ?? currentSelectedItem
        return tabBarVC.viewControllers?[defaultItem.rawValue] as? UINavigationController
    }
    
    func pushTo(_ item: TabBarItem, at viewControl: UIViewController) {
        guard let navigation = tabBarVC.viewControllers?[item.rawValue] as? UINavigationController else { return }
        navigation.popToRootViewController(animated: false)
        guard let viewControl = navigation.viewControllers.first else { return }
        viewControl.navigationController?.pushViewController(viewControl, animated: false)
    }
}


extension MainVCViewController {

    private func setupTabarVC() {
        // add view controller
        tabBarVC.setViewControllers(loadViewController(), animated: true)
        tabBarVC.delegate = self
        tabBarVC.selectedIndex = currentSelectedItem.rawValue
        tabBarVC.tabBar.isHidden = false
        tabBarVC.tabBar.itemPositioning = .fill
        addViewController(tabBarVC, into: vContainerTabBarVC)
        
    }
    
    private func loadViewController() -> [UIViewController] {
        return [UINavigationController(rootViewController: createViewController(item: .myHome)),
                UINavigationController(rootViewController: createViewController(item: .listExam)),
                UINavigationController(rootViewController: createViewController(item: .searchVC)),
                UINavigationController(rootViewController: createViewController(item: .myPage))
        ]
    }
    
    private func createViewController(item: TabBarItem) -> UIViewController {
        switch item {
        case .searchVC:
            return loadViewControl(view: SearchViewController.self, itemTabbar: item)
        case .myHome:
            return loadViewControl(view: MyHomeViewController.self, itemTabbar: item)
            
        case .myPage:
            return loadViewControl(view: SearchViewController.self, itemTabbar: item)
        case .listExam:
            return loadViewControl(view: ListMonHocViewController.self, itemTabbar: item)
        }
    }
    
    private func loadViewControl<T: UIViewController>(view: T.Type = T.self, itemTabbar: TabBarItem) -> T {
        let viewControl = T(nibName: T.nameClass, bundle: nil)
        let item = UITabBarItem()
        
        let itemTab = itemTabbar.getItem()
        
        item.title = itemTab.title.loadValue()
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -18)
        
        let attrsNormal = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11.0)
        ]
        item.setTitleTextAttributes(attrsNormal, for: .normal)
        
        item.image = UIImage(named: itemTab.icon)
        item.imageInsets = UIEdgeInsets(top: -17, left: 0, bottom: 0, right: 0)
        viewControl.tabBarItem = item
        tabBarItems.append(item)
        return viewControl
    }
}

extension MainVCViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        currentSelectedItem = TabBarItem(rawValue: tabBarController.selectedIndex) ?? .searchVC
        guard let navigation = viewController as? UINavigationController else { return }
        navigation.popToRootViewController(animated: false)
    }
}


