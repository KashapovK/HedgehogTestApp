//
//  AppDelegate.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false}
        setup(window)
        
        return true
    }
}

// MARK: - Private methods
extension AppDelegate {
    private func setup(_ window: UIWindow) {
        let navigationController = UINavigationController()
        let router = MainRouter(navigationController: navigationController)
        router.initialViewController()
        
        window.rootViewController = navigationController
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()
    }
}
