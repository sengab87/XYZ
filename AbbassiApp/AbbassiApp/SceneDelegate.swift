//
//  SceneDelegate.swift
//  AbbassiApp
//
//  Created by Ahmed Sengab on 4/17/21.
//

import UIKit
import Firebase
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let sign = UserDefaults.standard.value(forKey: "sign") as? Bool
        let uid = UserDefaults.standard.value(forKey: "UID") as? String
        let lockStatus = UserDefaults.standard.value(forKey: "account") as? String
        print(lockStatus," LOCKOP ")
        if (lockStatus == "locked")
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "lockController") as! LockViewController
            let navController = storyboard.instantiateViewController(identifier: "LockNav") as! UINavigationController
            navController.viewControllers = [viewController]
            self.window?.rootViewController = navController
            self.window!.makeKeyAndVisible()
        } else {
            if (sign == true){
                if (uid != nil){
                    if (uid == Auth.auth().currentUser?.uid){
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController = storyboard.instantiateViewController(identifier: "Video") as! CameraViewController
                        let navController = storyboard.instantiateViewController(identifier: "UUIDNav") as! UINavigationController
                        navController.viewControllers = [viewController]
                        self.window?.rootViewController = navController
                        self.window!.makeKeyAndVisible()
                    }else {
                        do {
                            try Auth.auth().signOut()
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let viewController = storyboard.instantiateViewController(identifier: "signup") as! SignUpViewController
                            let navController = storyboard.instantiateViewController(identifier: "UUIDNav") as! UINavigationController
                            navController.addChild(viewController)
                            self.window?.rootViewController = navController
                            self.window!.makeKeyAndVisible()
                        }
                        catch {
                            return
                        }
                       

                    }
                }else {
                    print(uid," OPSD")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(identifier: "UUID") as! UUIDViewController
                    let navController = storyboard.instantiateViewController(identifier: "UUIDNav") as! UINavigationController
                    navController.addChild(viewController)
                    self.window?.rootViewController = navController
                    self.window!.makeKeyAndVisible()
                }
               
            }else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "signup") as! SignUpViewController
                let navController = storyboard.instantiateViewController(identifier: "UUIDNav") as! UINavigationController
                navController.addChild(viewController)
                self.window?.rootViewController = navController
                self.window!.makeKeyAndVisible()
            }
        }
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

