//
//  QRCodeCaptureView.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 22/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import Foundation
import AVKit

class QRCodeCaptureView: BaseViewController, QRCodeCaptureViewContract, AVCaptureMetadataOutputObjectsDelegate {

	var presenter: QRCodeCapturePresenterContract!
    
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var URLLabel: UILabel!
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

	// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
        AppUtility.lockOrientation(.portrait)
        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
        self.tittleLabel.text = "Scan a QR Code"
        self.URLLabel.text = ""
    }

    private func setupView() {
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        view.bringSubviewToFront(tittleLabel)

        captureSession.startRunning()
    }
    
    func failed() {
        presenter.showNotSuportedAlert()
        captureSession = nil
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.URLLabel.text = stringValue
            self.tittleLabel.text = "Touch to open in Safary"
            view.bringSubviewToFront(tittleLabel)
            view.bringSubviewToFront(URLLabel)
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.found))
            URLLabel.addGestureRecognizer(tap)
        }
        dismiss(animated: true)
    }

    @objc func found() {
        // MARK: Cuando llego a esta función en el alterior método
        // ya he asegurado que el texto de URLLabel no está vacio.
        presenter.capturedURL(url: URLLabel.text!)
    }
}
