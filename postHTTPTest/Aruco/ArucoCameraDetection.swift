//
//  ArucoCameraDetection.swift
//  postHTTPTest
//
//  Created by Marcin Wawrzków on 08/06/2021.
//

import UIKit
import AVFoundation


class ArucoCameraDetection: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var previewView : UIView!
    var boxView:UIView!
    let myButton: UIButton = UIButton()

    //Camera Capture requiered properties
    var videoDataOutput: AVCaptureVideoDataOutput!
    var videoDataOutputQueue: DispatchQueue!
    var previewLayer:AVCaptureVideoPreviewLayer!
    var captureDevice : AVCaptureDevice!
    let session = AVCaptureSession()
    override func viewDidLoad() {
        print(OpenCVWrapper.getOpenCVVersion())
        super.viewDidLoad()
        super.viewDidLoad()
        previewView = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: UIScreen.main.bounds.size.width,
                                           height: UIScreen.main.bounds.size.height))
        previewView.contentMode = UIView.ContentMode.scaleAspectFit
        view.addSubview(previewView)

        //Add a view on top of the cameras' view
        boxView = UIView(frame: self.view.frame)

        myButton.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        myButton.backgroundColor = UIColor.gray
        myButton.layer.masksToBounds = true
        myButton.setTitle("Finish Mapping", for: .normal)
        myButton.setTitleColor(UIColor.black, for: .normal)
        myButton.layer.cornerRadius = 10.0
        myButton.layer.position = CGPoint(x: self.view.frame.width/2, y:
                                            self.view.frame.height-100)
        myButton.addTarget(self, action: #selector(self.onClickMyButton(sender:)), for: .touchUpInside)

        view.addSubview(boxView)
        view.addSubview(myButton)

        self.setupAVCapture()
    }
    
    override var shouldAutorotate: Bool {
        if (UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft ||
        UIDevice.current.orientation == UIDeviceOrientation.landscapeRight ||
        UIDevice.current.orientation == UIDeviceOrientation.unknown) {
            return false
        }
        else {
            return true
        }
    }
    func setupAVCapture(){
       session.sessionPreset = AVCaptureSession.Preset.vga640x480
       guard let device = AVCaptureDevice
       .default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                for: .video,
                position: AVCaptureDevice.Position.back) else {
                           return
       }
       captureDevice = device
       beginSession()
   }

   func beginSession(){
       var deviceInput: AVCaptureDeviceInput!

       do {
           deviceInput = try AVCaptureDeviceInput(device: captureDevice)
           guard deviceInput != nil else {
               print("error: cant get deviceInput")
               return
           }

           if self.session.canAddInput(deviceInput){
               self.session.addInput(deviceInput)
           }

           videoDataOutput = AVCaptureVideoDataOutput()
           videoDataOutput.alwaysDiscardsLateVideoFrames=true
           videoDataOutputQueue = DispatchQueue(label: "VideoDataOutputQueue")
        videoDataOutput.setSampleBufferDelegate(self, queue:self.videoDataOutputQueue)

           if session.canAddOutput(self.videoDataOutput){
               session.addOutput(self.videoDataOutput)
           }

           videoDataOutput.connection(with: .video)?.isEnabled = true
           previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
           previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect

           let rootLayer :CALayer = self.previewView.layer
           rootLayer.masksToBounds=true
           previewLayer.frame = rootLayer.bounds
           rootLayer.addSublayer(self.previewLayer)
           session.startRunning()
       } catch let error as NSError {
           deviceInput = nil
           print("error: \(error.localizedDescription)")
       }
   }

   func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
   }

   // clean up AVCapture
   func stopCamera(){
       session.stopRunning()
   }


    @objc func onClickMyButton(sender: UIButton){
        print("button pressed")
    }


}

