

import UIKit
import AVFoundation

class ColorRecogniserVC: UIViewController {
    
    var captureSession : AVCaptureSession!
    var previewLayer : AVCaptureVideoPreviewLayer!
    var backCamera : AVCaptureDevice!
    var backInput : AVCaptureInput!
    var videoOutput : AVCaptureVideoDataOutput!
    lazy var synthesizer = AVSpeechSynthesizer()

    lazy var circleView: UIView = {
        let view = UIView(frame: .init(x: 0, y: 0, width: 20, height: 20))
        view.layer.cornerRadius = 20/2
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 20),
            view.heightAnchor.constraint(equalToConstant: 20)
        ])
        return view
    }()
    
    lazy var displayColorName: UILabel = {
        let label = UILabel(frame: .init(x: 100, y: 0, width: 200, height: 40))
        label.text = "none"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelContainerView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: effect)
        view.contentView.addSubview(displayColorName)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            displayColorName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            displayColorName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            displayColorName.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            displayColorName.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)
        ])
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    var restrictToPortrait: (Bool) -> Void
    
    init(restrictToPortrait: @escaping (Bool) -> Void) {
        self.restrictToPortrait = restrictToPortrait
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        checkPermissions()
        setupAndStartCaptureSession()
        setUpCircleView()
        setUpDisplayLabel()
    }
    
    @objc func setBackgroundColorLabel(_ color: UIColor) {
        displayColorName.text = color.accessibilityName.capitalized
        
        let utterance = AVSpeechUtterance(string: displayColorName.text ?? "")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
        ColorRecogniserVC.cancelPreviousPerformRequests(withTarget: self)
    }
        
    func setUpCircleView() {
        view.addSubview(circleView)
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: circleView.centerYAnchor)
        ])
        view.bringSubviewToFront(circleView)
    }
    
    func setUpDisplayLabel() {
        view.addSubview(labelContainerView)
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalTo: labelContainerView.bottomAnchor, constant: 100),
            view.centerXAnchor.constraint(equalTo: labelContainerView.centerXAnchor)])
        view.bringSubviewToFront(labelContainerView)
    }
    
    private func updatePreviewLayer(layer: AVCaptureConnection) {
        self.previewLayer?.frame = view.bounds
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let connection = self.previewLayer?.connection {
            let previewLayerConnection: AVCaptureConnection = connection
            self.updatePreviewLayer(layer: previewLayerConnection)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        restrictToPortrait(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ColorRecogniserVC.cancelPreviousPerformRequests(withTarget: self)
        synthesizer.pauseSpeaking(at: .immediate)
        restrictToPortrait(false)
    }
    
    func setupPreviewLayer(){
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.insertSublayer(previewLayer, at: 0)
        previewLayer.videoGravity = .resizeAspectFill
    }
    
    func setupAndStartCaptureSession(){
        DispatchQueue.global(qos: .userInitiated).async{
            self.captureSession = AVCaptureSession()
            self.captureSession.beginConfiguration()
            
            if self.captureSession.canSetSessionPreset(.photo) {
                self.captureSession.sessionPreset = .photo
            }
            self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
            
            self.setupInputs()
            
            DispatchQueue.main.async {
                self.setupPreviewLayer()
                self.previewLayer?.frame = self.view.layer.frame
            }
            
            self.setupOutput()
            self.captureSession.commitConfiguration()
            self.captureSession.startRunning()
        }
    }
    
    func setupInputs(){
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            backCamera = device
        } else {
            fatalError("no back camera")
        }
        guard let bInput = try? AVCaptureDeviceInput(device: backCamera) else {
            fatalError("could not create input device from back camera")
        }
        backInput = bInput
        if !captureSession.canAddInput(backInput) {
            fatalError("could not add back camera input to capture session")
        }
        captureSession.addInput(backInput)
    }
    
    func setupOutput(){
        videoOutput = AVCaptureVideoDataOutput()
        let videoQueue = DispatchQueue(label: "videoQueue", qos: .userInteractive)
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        } else {
            fatalError("could not add video output")
        }
    }
    
    
    func checkPermissions() {
        let cameraAuthStatus =  AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch cameraAuthStatus {
        case .authorized:
            return
        case .denied:
            abort()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { (authorized) in
                if !(authorized) {
                    abort()
                }
            }
        case .restricted:
            abort()
        @unknown default:
            fatalError()
        }
    }
}

extension ColorRecogniserVC: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if let buffer = sampleBuffer.imageBuffer {
            let ciImage = CIImage(cvPixelBuffer: buffer)
            let context = CIContext(options: nil)
            guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
                return
            }
            let color = cgImage.getCenterPixelColor(extent: ciImage.extent)
            DispatchQueue.main.async {
                self.circleView.backgroundColor = color
                self.perform(#selector(self.setBackgroundColorLabel(_:)), with: color, afterDelay: 2)
            }
        }
    }
}

extension CGImage {
    
    func getCenterPixelColor(extent: CGRect) -> UIColor {
        let center = CGPoint(x: extent.midX, y: extent.midY)
        return getPixelColor(pos: center, extent: extent)
    }
    
    func getPixelColor(pos: CGPoint, extent: CGRect) -> UIColor {

        let pixelData = dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(extent.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

import SwiftUI

struct ColorRecogniserView: UIViewControllerRepresentable {
    var restrictToPortrait: (Bool) -> Void
    func makeUIViewController(context: Context) -> ColorRecogniserVC {
        ColorRecogniserVC(restrictToPortrait: restrictToPortrait)
    }
    
    func updateUIViewController(_ uiViewController: ColorRecogniserVC, context: Context) {
    }
}
