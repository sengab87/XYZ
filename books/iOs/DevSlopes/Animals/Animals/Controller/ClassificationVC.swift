//
//  ViewController.swift
//  Animals
//
//  Created by Ahmed Sengab on 1/20/19.
//  Copyright © 2019 Ahmed Sengab. All rights reserved.
//

import UIKit
import Vision
import CoreML

class ClassificationVC: UIViewController {

    lazy var classificationRequest : VNCoreMLRequest = {
        do {
             let model = try VNCoreMLModel(for: AnimalClassifier().model)
             let request = VNCoreMLRequest(model: model, completionHandler: { (request, error) in
                self.classification(for: request, error:error)
             })
             request.imageCropAndScaleOption = .centerCrop
             return request
        } catch{
             fatalError("failed to load vision ML model\(error)")
        }
    }()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var classificationLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func cameraBtnWasPressed(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            presentPhotoPicket(sourceType: .photoLibrary)
            return
        }
        let photoSourcePicker = UIAlertController()
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (_) in
            // present photo picker with camera
            self.presentPhotoPicket(sourceType: .camera)
        }
        let choosePhotoAction = UIAlertAction(title: "Choose Photo", style: .default) { (_) in
            self.presentPhotoPicket(sourceType: .photoLibrary)
            //
        }
        photoSourcePicker.addAction(takePhoto)
        photoSourcePicker.addAction(choosePhotoAction)
        photoSourcePicker.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(photoSourcePicker,animated: true,completion: nil)
    }
    func updateClassification(for Image: UIImage)
    {
        classificationLbl.text = "Classifaying"
        guard let orientation = CGImagePropertyOrientation(rawValue: UInt32(Image.imageOrientation.rawValue)) , let ciimage = CIImage(image: Image) else {
            return
        }
        DispatchQueue.global(qos: .userInteractive).async {
        let handler = VNImageRequestHandler(ciImage: ciimage, orientation: orientation, options: [:])
        do {
            try handler.perform([self.classificationRequest])
        }catch{
            
            }
        }
    }
    func classification(for request: VNRequest, error: Error?)
    {
        guard let classifications = request.results as? [VNClassificationObservation] else {
            self.classificationLbl.text = "Unable to classify.\n\(error?.localizedDescription) Error"
            return
        }
        if (classifications.isEmpty)
        {
            self.classificationLbl.text = "Nothing Recognizied"
        }
        else {
            let topClassifications = classifications.prefix(2)
            let descripition = topClassifications.map{
                classification in
                return String(format: "%.2f", classification.confidence * 100) + "% -" + classification.identifier
            }
            DispatchQueue.main.async {
                self.classificationLbl.text = "classifications:\n" + descripition.joined(separator: "\n") }
        }
    }
    func presentPhotoPicket(sourceType : UIImagePickerController.SourceType)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker,animated: true,completion: nil)
    }
    
}
extension ClassificationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Problem")
        }
        imageView.image = image
        updateClassification(for: image)
        // use to make predictions with core ML models
    }
}

