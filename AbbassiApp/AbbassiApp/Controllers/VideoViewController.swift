//
//  VideoViewController.swift
//  AbbassiApp
//
//  Created by Ahmed Sengab on 5/9/21.
//

import UIKit
import AVKit
import Firebase
import PMAlertController
let token = "mAVVjEPZ0rwAAAAAAAAAAUEWuXvokB8IcTJoNa8zjdLRmqbvLb3TiizPOPMYGJde"

class VideoViewController: ConnectionStatusViewController, AVPlayerViewControllerDelegate{
    var link:String!
    var status: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let splitLink = link.components(separatedBy: "http://")[1].components(separatedBy: "/")
        self.parseVideoString(link: splitLink)
        let isCaptured = UIScreen.main.isCaptured
        UIScreen.main.addObserver(self, forKeyPath: "captured", options: .new, context: nil)
        
        if (isCaptured){
            lockAccount()
            
        }
        
    }
    private func sendVideo(path:String, handler: @escaping(_ status: String?)->()){
        
        let url = URL(string: "https://api.dropboxapi.com/2/files/get_temporary_link")!

        // prepare json data
 
        let json: [String: Any] = ["path": path]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                guard let result = responseJSON["link"] as? String
                else {
                    handler(nil)
                    return
                }
                handler(result)
            }
        }

        task.resume()
    }
    private func parseVideoString(link: [String]){
        /// Check  school
        print(link," LINK ")
        let userSchool = UserDefaults.standard.object(forKey: "school")
        if (userSchool == nil){
            UsersWebServices.instance.getUserSchool { currentSchool in
                UserDefaults.standard.setValue(currentSchool, forKey: "school")
                let school = UserDefaults.standard.object(forKey: "school") as! String
                        UsersWebServices.instance.getSchoolCurrentPage(school: school, notes: link[0], page: link[1]) { status in
                            if (status){
                                DispatchQueue.main.async {
                                    self.showView(link: self.link,parsedLink: "/" + link[0] + "/" + link[2])
                                }
                            }else {
                                
                            }
                       }
            }
        }else {
            UsersWebServices.instance.getSchoolCurrentPage(school: userSchool as! String, notes: link[0], page: link[1]) { status in
                if (status){
                    DispatchQueue.main.async {
                        self.showView(link: self.link,parsedLink: "/" + link[0]+"/"+link[2])
                    }
                }else {
                    
                }
           }
        }
        
    }
    func playerViewController(_: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator: UIViewControllerTransitionCoordinator) {
        let viewController = storyboard?.instantiateViewController(identifier: "Video") as! CameraViewController
        let navController = storyboard?.instantiateViewController(identifier: "UUIDNav") as! UINavigationController
        navController.viewControllers = [viewController]
        UIApplication.shared.windows.first?.rootViewController = navController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    private func showView(link: String, parsedLink: String){
        self.sendVideo(path:parsedLink) { status in
            if (status != nil) {
                DispatchQueue.main.async {
                    let player = AVPlayer(url:URL(string:status!)!)
                    let playerController = AVPlayerViewController()
                    playerController.player = player
                    playerController.delegate = self
                    self.present(playerController, animated: true)
                }
            }else {
                /// Dimis video
            }
        }
    }
    private func checkCurrentPage(page: String, notes: String, handler: @escaping(_ currentPage: Bool)->()){
        let schoolName = UserDefaults.standard.object(forKey: "school") as! String
        UsersWebServices.instance.getSchoolCurrentPage(school: schoolName, notes: notes, page: page) { status in
            if (status) {
                handler(true)
            } else {
                handler(false)
            }
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "captured") {
            let isCaptured = UIScreen.main.isCaptured
            if(isCaptured){
                lockAccount()
            }
        }
    }
    private func lockAccount(){
        UserDefaults.standard.setValue("locked", forKey: "account")
    }
    
}

