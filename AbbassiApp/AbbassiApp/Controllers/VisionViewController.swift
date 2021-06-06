//
//  VisionViewController.swift
//  AbbassiApp
//
//  Created by Ahmed Sengab on 5/9/21.
//

import UIKit
import Vision
import AVFoundation
import PMAlertController
class VisionViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var captureSession = AVCaptureSession()

    lazy var detectBarcodeRequest = VNDetectBarcodesRequest { request, error in
      guard error == nil else {
        self.showAlert(
            withTitle: "Barcode error",
          message: error?.localizedDescription ?? "error")
        return
      }
      self.processClassification(request)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.determineCameraStatus()
        self.setupCameraView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
    }
    
    private func setupCameraView(){
        captureSession.sessionPreset = .hd1280x720

        // TODO: Add input
        let videoDevice = AVCaptureDevice
          .default(.builtInWideAngleCamera, for: .video, position: .back)

        guard
          let device = videoDevice,
          let videoDeviceInput = try? AVCaptureDeviceInput(device: device),
          captureSession.canAddInput(videoDeviceInput) else {
            showAlert(
              withTitle: "Cannot Find Camera",
              message: "There seems to be a problem with the camera on your device.")
            return
          }

        captureSession.addInput(videoDeviceInput)

        // TODO: Add output
        let captureOutput = AVCaptureVideoDataOutput()
        // TODO: Set video sample rate
        captureOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .default))
        captureSession.addOutput(captureOutput)

        configurePreviewLayer()

        // TODO: Run session
        captureSession.startRunning()
    }
    private func determineCameraStatus()
    {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
          AVCaptureDevice.requestAccess(for: .video) { [self] granted in
            if !granted {
                showPermissionsAlert()
            }
          }
        case .denied, .restricted:
            showPermissionsAlert()

        default:
          return
        }
    }
   
    private func showPermissionsAlert() {
      showAlert(
        withTitle: "Camera Permissions",
        message: "Please open Settings and grant permission for this app to use your camera.")
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
      // TODO: Live Vision
      guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
      let imageRequestHandler = VNImageRequestHandler(
        cvPixelBuffer: pixelBuffer,
        orientation: .right)

      do {
        try imageRequestHandler.perform([detectBarcodeRequest])
      } catch {
      }
    }
    
    func processClassification(_ request: VNRequest) {
      // TODO: Main logic
      guard let barcodes = request.results else { return }
      DispatchQueue.main.async { [self] in
        if captureSession.isRunning {

          

          for barcode in barcodes {
            guard
              // TODO: Check for QR Code symbology and confidence score
              let potentialQRCode = barcode as? VNBarcodeObservation,
              potentialQRCode.symbology == .QR,
              potentialQRCode.confidence > 0.9
              else { return }

            observationHandler(payload: potentialQRCode.payloadStringValue)
          }
        }
      }
    }
    func observationHandler(payload: String?) {
      // TODO: Open it in Safari
      guard
        let payloadString = payload,
        let url = URL(string: payloadString)?.absoluteString
        
      else {
        invalidQrCode()
        self.navigationController?.popViewController(animated: true)
        return
        
      }
        
        if (url.contains("P1NOTES") || url.contains("P2NOTES") || url.contains("M11NOTES") || url.contains("P1CLASSIFIED") || url.contains("P2CLASSIFIED") || url.contains("M1CLASSIFIED")){
            self.testing(payload: payloadString)
        }else {
            
            invalidQrCode()
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    private func testing(payload: String){
        self.performSegue(withIdentifier: "video", sender: payload)
    }
    override func viewWillDisappear(_ animated: Bool) {
        captureSession.stopRunning()
    }
    private func showAlert(withTitle title: String, message: String) {
      DispatchQueue.main.async {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true)
      }
    }
    private func configurePreviewLayer() {
      let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
      cameraPreviewLayer.videoGravity = .resizeAspectFill
      cameraPreviewLayer.connection?.videoOrientation = .portrait
      cameraPreviewLayer.frame = view.frame
      view.layer.insertSublayer(cameraPreviewLayer, at: 0)
    }
    private func invalidQrCode(){
        let alertVC = PMAlertController(title: "QR Code Status", description: "Invalid QR Code", image: #imageLiteral(resourceName: "stop_image"), style: .alert)

        alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: {
            alertVC.dismiss(animated: true, completion: nil)
        }))

        self.present(alertVC, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "video")
        {
            if let destinationVC = segue.destination as? VideoViewController
            {
                if let plan = sender as? String
                {
                    destinationVC.link = plan
                    destinationVC.status = true
                }
            }
        }
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
          if motion == .motionShake {
            self.navigationController?.popViewController(animated: true)
          }
    }

}
