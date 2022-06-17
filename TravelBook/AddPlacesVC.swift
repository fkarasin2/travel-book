//
//  AddPlacesVC.swift
//  TravelBook
//
//  Created by Hayrullah Faruk KARAŞIN on 21.03.2022.
//

import UIKit

class AddPlacesVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var dscrption: UITextField!
    @IBOutlet weak var locationName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosenImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        let gestureReco = UITapGestureRecognizer(target: self, action: #selector(hiddenKeyboard))
        view.addGestureRecognizer(gestureReco)
        
}
    @objc func hiddenKeyboard(){
        view.endEditing(true)
    }
    
    @objc func choosenImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    @IBAction func nextButton(_ sender: Any) {
        
        if locationName.text != "" && dscrption.text != "" {
            if let choosenImage = imageView.image{
                PlaceModel.sharedInstance.placeName = locationName.text!
                PlaceModel.sharedInstance.description = dscrption.text!
                PlaceModel.sharedInstance.placeImage = choosenImage
            }
            self.performSegue(withIdentifier: "toMapVC", sender: nil)
        }else{
            makeAlert(titleInput: "Eroor", messageInput: "Value is Empty")
        }
        
        
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    func makeAlert(titleInput: String, messageInput:String) {
           let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
           let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
           alert.addAction(okButton)
           self.present(alert, animated: true, completion: nil)
       }
    

    

}
