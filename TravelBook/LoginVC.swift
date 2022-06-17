//
//  ViewController.swift
//  TravelBook
//
//  Created by Hayrullah Faruk KARAŞIN on 21.03.2022.
//

import UIKit
import Parse

class LoginVC: UIViewController {
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var userNameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecog = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecog)
        // Do any additional setup after loading the view.
    }
    @IBAction func signInClicked(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != "" {
                    
                    PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { (user, error) in
                        if error != nil {
                            self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                        } else {
                            
                            // Segue
                            self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                            
                        }
                    }
                    
                } else {
                    makeAlert(titleInput: "Error", messageInput: "Username / Password??")
                }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != "" {
                   
                   let user = PFUser()
                   user.username = userNameText.text!
                   user.password = passwordText.text!
                   
                   user.signUpInBackground { (success, error) in
                       if error != nil {
                           self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!!")
                       } else {
                           self.performSegue(withIdentifier: "toPlacesVC", sender: nil)

                       }
                   }
                   
               } else {
                   makeAlert(titleInput: "Error", messageInput: "Username / Password??")
               }
    }
    func makeAlert(titleInput: String, messageInput:String) {
           let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
           let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
           alert.addAction(okButton)
           self.present(alert, animated: true, completion: nil)
       }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
}

