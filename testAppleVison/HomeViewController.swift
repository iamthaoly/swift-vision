//
//  HomeViewController.swift
//  testAppleVison
//
//  Created by CycTrung on 1/20/21.
//  Copyright © 2021 CycTrung. All rights reserved.
//

import UIKit
import Vision
class HomeViewController: UIViewController {

    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var request = VNRecognizeTextRequest(completionHandler: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        //stopActivity()
        
        // Do any additional setup after loading the view.
    }
   // private func startActivity(){
   //     activityIndicator.startAnimating()
    //}
    //private func stopActivity(){
   //     activityIndicator.stopAnimating()
    //}

    @IBAction func touch(_ sender: Any) {
       setupGallery()
    }
    private func setupGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePhotoLibrayPick = UIImagePickerController()
            imagePhotoLibrayPick.delegate = self
            imagePhotoLibrayPick.allowsEditing = true
            imagePhotoLibrayPick.sourceType = .photoLibrary
            self.present(imagePhotoLibrayPick, animated: true, completion: nil)
        }
    }
    private func setupVisionRecongnitionText(image: UIImage?){
        var textString = ""
        request = VNRecognizeTextRequest(completionHandler: {(request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {fatalError("Recieved Invaild Observation") }
            for observation in observations{
                guard let topCandidate = observation.topCandidates(1).first else {
                    print("No candidate")
                    continue
                }
                textString += "\n\(topCandidate.string)"
                DispatchQueue.main.sync {
                    //self.stopActivity()
                    self.textView.text = textString
                  
                }
            }
            print(textString)
        })
        //add some propertie
        request.customWords = ["custom"]
        request.minimumTextHeight = 0.03125
        request.recognitionLevel = .fast
        request.recognitionLanguages = ["en_US"]
        request.usesLanguageCorrection = true
        
        let requests = [request]
        
        //creating requests handler
        DispatchQueue.global(qos: .userInitiated).async {
            guard let img = image?.cgImage else {fatalError("Miss image to scan")}
            let handle = VNImageRequestHandler(cgImage: img, options: [:])
                try? handle.perform(requests)
        }
       
    }
    
}
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        //startActivity()
        self.textView.text = ""
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imageView.image = image
        setupVisionRecongnitionText(image: image)
    }
}
