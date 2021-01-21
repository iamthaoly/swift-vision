//
//  HomeViewController.swift
//  testAppleVison
//
//  Created by CycTrung on 1/20/21.
//  Copyright © 2021 CycTrung. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    private func startActivity(){
        activityIndicator.startAnimating()
    }
    private func stopActivity(){
        activityIndicator.stopAnimating()
    }

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
        var request = VNReco
    }
}
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imageView.image = image
    }
}
