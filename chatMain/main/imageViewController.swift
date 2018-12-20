//
//  imageViewController.swift
//  chatMain
//
//  Created by Ahmed Sengab on 9/18/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import UserNotifications
import CoreGraphics
import CoreImage

class imageViewController: connectionStatus, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,mainProtocol {

    var fillLayer = CAShapeLayer()
    var screenWidth : CGFloat!
    var screenHeight : CGFloat!
    var radius : CGFloat!
    var mainScroll = UIScrollView()
    var backView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        openCamera()
        
        XMPPTest.shared.vcardProfilePicDelegate = self
        mainScroll.delegate = self
        mainScroll.minimumZoomScale = 1
        mainScroll.maximumZoomScale = 3.0
        AppUtility.lockOrientation(.portrait)

    }
    func openCamera()
    {
    
        
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if (response) {
             
            }
            else {
                
            }
        }
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if (status) == .authorized{
                }
                else {
                    
                }
            })
        }
        
  
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
       
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
           self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
            print(1)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }

   
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            print(sourceType.rawValue)
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self

            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
            
           self.tabBarController?.tabBar.isHidden = true
           self.navigationController?.isNavigationBarHidden = true
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as! UIImage
        backView.contentMode = .scaleAspectFit
        backView.image = image
        self.view.backgroundColor = UIColor.black
        picker.dismiss(animated: true, completion: nil)
        photoSave()
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)

    }
    func photoSave()
    {
        let currentImage = backView.image
        let newimage1 = backView.image
        if (Double((currentImage?.size.width)!) < Double((currentImage?.size.height)!))
        {
            
            
            screenWidth = UIScreen.main.bounds.width
            screenHeight = UIScreen.main.bounds.height
            let padding = (UIScreen.main.bounds.height - UIScreen.main.bounds.width)/2.5
            radius = min(screenWidth,screenHeight)
            
            let hypo = sqrt(pow((backView.image?.size.height)!,2) + pow((backView.image?.size.width)!,2))
            let adjustedWidth = (backView.image?.size.width)! * screenWidth / hypo
            let adjustedHeigth = (backView.image?.size.height)! * screenWidth / hypo
            
            print(adjustedWidth,adjustedHeigth)
            mainScroll.frame = CGRect(x: 0, y: padding, width: screenWidth, height: screenHeight - (2 * padding))
            print(mainScroll.frame)
            print(mainScroll.bounds)
            backView.frame = mainScroll.bounds
            print(backView.frame)
            mainScroll.contentSize = mainScroll.frame.size
            
            let context = CIContext(options: nil)
            let inputImage = CIImage(cgImage: (currentImage?.cgImage)!)
            let filter = CIFilter(name: "CIGaussianBlur")
            filter?.setValue(inputImage, forKey: kCIInputImageKey)
            filter?.setValue(100.0, forKey: "inputRadius")
            let result = (filter?.value(forKey: kCIOutputImageKey))
            
            /*  CIGaussianBlur has a tendency to shrink the image a little, this ensures it matches
             *  up exactly to the bounds of our original image */
            let cgImage = context.createCGImage(result as! CIImage, from: inputImage.extent)
            
            let retVal = UIImage(cgImage: cgImage!, scale: (currentImage?.scale)!, orientation: (currentImage?.imageOrientation)!)
            
            
            
            
            UIGraphicsBeginImageContextWithOptions(backView.frame.size,false,0)
            retVal.draw(in: mainScroll.bounds)
            newimage1?.draw(in: CGRect(x: (screenWidth - adjustedWidth) / 2, y: (screenHeight - adjustedHeigth)/2 - padding, width: adjustedWidth, height: adjustedHeigth))
            var newimage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            backView.image = newimage
           
            self.view.addSubview(mainScroll)
            self.mainScroll.addSubview(backView)
           
            
            let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), cornerRadius: 0)
            let circlePath = UIBezierPath(roundedRect: CGRect(x:0, y: screenHeight/2 - radius/2 , width: radius, height: radius), cornerRadius: radius/2)
            
            path.append(circlePath)
            
            path.usesEvenOddFillRule = true
            fillLayer.path = path.cgPath
            fillLayer.fillRule = CAShapeLayerFillRule.evenOdd
            fillLayer.fillColor = UIColor.black.cgColor
            fillLayer.opacity = 0.8
            
            view.layer.addSublayer(fillLayer)
            let butt = UIButton(type: .system)
            butt.frame = CGRect(x: screenWidth - 75.0, y: screenHeight - 80.0, width: 70.0, height: 40.0)
            butt.tintColor = UIColor.white
            butt.setTitle("Save", for: .normal)
            butt.setTitleColor(UIColor.white, for: .normal)
            butt.titleLabel?.font = butt.titleLabel?.font.withSize(20)
            butt.titleLabel?.textAlignment = .center
            view.addSubview(butt)
            
            let cancbutt = UIButton(type: .system)
            cancbutt.frame = CGRect(x: 5, y: screenHeight - 80.0, width: 70.0, height: 40.0)
            cancbutt.setTitle("Cancel", for: .normal)
            cancbutt.setTitleColor(UIColor.white, for: .normal)
            cancbutt.titleLabel?.font = cancbutt.titleLabel?.font.withSize(20)
            cancbutt.titleLabel?.textAlignment = .center
            view.addSubview(cancbutt)
            cancbutt.addTarget(self, action: #selector(cancelButtonPressed), for: .touchDown)
            butt.addTarget(self, action: #selector(doneButtonPressed), for: .touchDown)
            let label = UILabel()
            label.frame = CGRect(x: screenWidth/2 - 40, y: (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.size.height + 8, width: 150, height: 40)
            label.text = "Resize and Move"
            label.tintColor = UIColor.white
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.center = CGPoint(x: screenWidth/2, y: (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.size.height + 8)
            label.font = label.font.withSize(20)
            self.view.addSubview(label)
        }
        else{
            
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return backView
    }
    
    @objc func doneButtonPressed()
    {
       
       
        let finalImage = backView.image?.cgImage
        
        
        
        ////////////////////////////////

        let imageViewScale = max( CGFloat(finalImage!.width) / mainScroll.contentSize.width ,
                                  CGFloat(finalImage!.height) / mainScroll.contentSize.height)
        print( "mainScroll Content size", mainScroll.contentSize)
        print("imageViewscale" , imageViewScale)
        var visibleRect = CGRect()
        visibleRect.origin.x = mainScroll.contentOffset.x * imageViewScale
        visibleRect.origin.y =  ((mainScroll.contentOffset.y) + ((mainScroll.frame.height - radius) / 2)) * imageViewScale
        visibleRect.size.width = radius * imageViewScale
        visibleRect.size.height =  radius * imageViewScale
        print("visible rect", visibleRect)
        print("mainScroll Content offset", mainScroll.contentOffset)
        let finalimg = self.cropImage(srcImage: finalImage!,croprect: visibleRect)
        let compressedImage = finalimg.compressImage()
        let finalimg1 = compressedImage!.jpegData(compressionQuality: 0.1)
        print("the image size is", finalimg1!.count / 1024)
        UserDefaults.standard.set(finalimg1!, forKey: "profileImage")
        
           XMPPTest.shared.sendVcard(ProfilePic: finalimg1)
        
        
       
    }
    @objc func cancelButtonPressed()
    {
        //self.navigationController?.popViewController(animated: true)
        AppUtility.lockOrientation(.all)
        self.navigationController?.popViewController(animated: true)
        

    }
   
  
    func cropImage(srcImage:CGImage, croprect:CGRect) -> UIImage
    {
       
        let crop = (srcImage.cropping(to: croprect ))
        let final = UIImage(cgImage: crop!)
        print("the final image size is",final.size)
        return final
    }
    func vCardPhotoSent(value: Bool)
    {
        if (value == true)
        {
            print("yes")
            AppUtility.lockOrientation(.all)
            let viewControllers = self.navigationController?.viewControllers
            self.navigationController?.popToViewController(viewControllers![0], animated: true)
        }
        if (value == false)
        {
             UserDefaults.standard.removeObject(forKey: "profileImage")
            
        }
    }

 }

extension UIImage
{
func compressImage() -> UIImage? {
    // Reducing file size to a 10th
    var actualHeight: CGFloat = self.size.height
    var actualWidth: CGFloat = self.size.width
    let maxHeight: CGFloat = 1136.0
    let maxWidth: CGFloat = 640.0
    var imgRatio: CGFloat = actualWidth/actualHeight
    let maxRatio: CGFloat = maxWidth/maxHeight
    var compressionQuality: CGFloat = 0.5
    
    if actualHeight > maxHeight || actualWidth > maxWidth {
        if imgRatio < maxRatio {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight
            actualWidth = imgRatio * actualWidth
            actualHeight = maxHeight
        } else if imgRatio > maxRatio {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth
            actualHeight = imgRatio * actualHeight
            actualWidth = maxWidth
        } else {
            actualHeight = maxHeight
            actualWidth = maxWidth
            compressionQuality = 1
        }
    }
    let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
    UIGraphicsBeginImageContext(rect.size)
    self.draw(in: rect)
    guard let img = UIGraphicsGetImageFromCurrentImageContext() else {
        return nil
    }
    UIGraphicsEndImageContext()
    guard let imageData = img.jpegData(compressionQuality: compressionQuality) else {
        return nil
    }
    return UIImage(data: imageData)
    }
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
