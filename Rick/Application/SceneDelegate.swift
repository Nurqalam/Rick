//
//  SceneDelegate.swift
//  Rick
//
//  Created by Nurqalam on 04.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.font: UIFont(name: "HelveticaNeue-bold", size: 18) as Any,
                                          .foregroundColor: UIColor.specialGreen]
        appearance.backgroundColor = .specialBackground
        UINavigationBar.appearance().tintColor = .specialGreen
        UINavigationBar.appearance().standardAppearance = appearance
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6852297278, green: 0.784557269, blue: 0.3174464407, alpha: 1),
                                          NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-bold", size: 22)!]

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        window?.makeKeyAndVisible()

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
