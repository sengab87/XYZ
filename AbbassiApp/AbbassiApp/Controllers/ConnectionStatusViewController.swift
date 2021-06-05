//
//  ConnectionStatusViewController.swift
//  AbbassiApp
//
//  Created by Ahmed Sengab on 5/25/21.
//

import UIKit

import Network

import NVActivityIndicatorView

class ConnectionStatusViewController: UIViewController {

    var nwPathMonitor = NWPathMonitor()

    var mainView = UIView()
   
    var internetView = UIView()
    
    let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: (UIScreen.main.bounds.width - 200 )/2, y: (UIScreen.main.bounds.height - 350 )/2, width: 200, height: 200), type: .ballScaleMultiple, color: #colorLiteral(red: 0.1882352941, green: 0.8392156863, blue: 0.6901960784, alpha: 1), padding: 20)
    let interentActivityIndicator = NVActivityIndicatorView(frame: CGRect(x: (UIScreen.main.bounds.width - 120 )/2, y: (UIScreen.main.bounds.height - 350 )/2, width: 120, height: 120), type: .ballPulse, color: #colorLiteral(red: 0.4087875187, green: 0.8293591142, blue: 0.6989322305, alpha: 1), padding: 20)
    override func viewDidLoad() {
        super.viewDidLoad()
        nwPathMonitor.start(queue: DispatchQueue(label: "network_monitor"))
        nwPathMonitor.pathUpdateHandler = { path in

            if (path.status == .satisfied){
                if (path.usesInterfaceType(.wifi)){
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 1.5) {
                            self.internetView.alpha = 0
                        } completion: { (completed) in
                            if (completed){
                                self.activityIndicatorView.stopAnimating()
                                self.interentActivityIndicator.stopAnimating()
                                self.internetView.removeFromSuperview()
                            }
                        }

                    }
                }
                if (path.usesInterfaceType(.cellular)){
                    print("cellular")
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 1.5) {
                            self.internetView.alpha = 0
                        } completion: { (completed) in
                            if (completed){
                                self.activityIndicatorView.stopAnimating()
                                self.interentActivityIndicator.stopAnimating()
                                self.internetView.removeFromSuperview()
                            }
                        }
                    }

                }
            }
            if (path.status == .unsatisfied)
            {
                DispatchQueue.main.async {
                    
                    self.internetStatus()
                    UIView.animate(withDuration: 1.5) {
                            self.internetView.isHidden = false
                            self.internetView.alpha = 1
                        }

                }
            }
            if (path.status == .requiresConnection){

            }
            
        }
        
    }
    func internetStatus(){
        internetView.frame = UIScreen.main.bounds
        internetView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(internetView)
        let label = UILabel(frame: CGRect(x:(UIScreen.main.bounds.width - 200 )/2 , y: (UIScreen.main.bounds.height - 450 )/2+216, width: 200, height: 80))
        label.textAlignment = .center
        label.text = "Please check your internet connection"
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.tintColor = .black
        label.numberOfLines = 2
        self.internetView.addSubview(interentActivityIndicator)
        self.internetView.addSubview(label)
        interentActivityIndicator.startAnimating()
        internetView.isHidden = true
        
    }
    func addTranstion(){
        mainView.frame = UIScreen.main.bounds
        mainView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(mainView)
        let label = UILabel(frame: CGRect(x:(UIScreen.main.bounds.width - 200 )/2 , y: (UIScreen.main.bounds.height - 350 )/2+216, width: 200, height: 80))
        label.textAlignment = .center
        label.text = "Please Wait This Might take a few Moments"
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.tintColor = .black
        label.numberOfLines = 2
        self.mainView.addSubview(activityIndicatorView)
        self.mainView.addSubview(label)
        activityIndicatorView.startAnimating()
        
    }
    func removeOverlay(){
        self.mainView.removeFromSuperview()
    }

}
