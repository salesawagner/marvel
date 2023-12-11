//
//  AppDelegate.swift
//  Marvel
//
//  Created by Wagner Sales on 06/12/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()

        let viewController = CharactersViewController.create()
        let navigationController = UINavigationController(rootViewController: viewController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .black


        // Navigation bar appearance
        let navAppearance = UINavigationBar.appearance()
        navAppearance.barTintColor = .white
        navAppearance.isTranslucent = false


        return true
    }
}
