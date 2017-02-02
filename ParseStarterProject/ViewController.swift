/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signUpMode = true;
    
    var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    @IBOutlet var emailText: UITextField!
    
    @IBOutlet var passwordText: UITextField!
    
    @IBOutlet var signUpOrLogInButton: UIButton!
    
    @IBAction func signUpOrLogIn(_ sender: Any) {
        
        if emailText.text == "" || passwordText.text == "" {
            
            createAlert(title: "Enter Credentials", message: "Please fill email/password")
            
            
        } else {
            
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            UIApplication.shared.beginIgnoringInteractionEvents()
            activityIndicator.startAnimating()
            
            if signUpMode {
               
                //Sign Up
                let user = PFUser()
                
                user.username = emailText.text
                user.email = emailText.text
                user.password = passwordText.text
                
                user.signUpInBackground(block: { (success, error) in
                    
                    
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try Again"
                        
                        if let errorMessage = error?.localizedDescription {
                            
                            displayErrorMessage = errorMessage
                        }
                        
                        self.createAlert(title: "Error in form", message: displayErrorMessage)
                        
                    } else {
                        
                        print("User Signed Up")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                        
                        
                    }
                    
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.activityIndicator.stopAnimating()
                    
                })
                
            } else {
                
                PFUser.logInWithUsername(inBackground: emailText.text!, password: passwordText.text!, block: { (user, error) in
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try Again"
                        
                        if let errorMessage = error?.localizedDescription {
                            
                            displayErrorMessage = errorMessage
                        }
                        
                        self.createAlert(title: "Log in Error", message: displayErrorMessage)
                        
                    } else {
                        
                        print("Login Succeed")
                        
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                        
                    }
                    
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.activityIndicator.stopAnimating()

                    
                })
                
            }
            
            
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
        
            self.performSegue(withIdentifier: "showUserTable", sender: self)
            
        }
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func createAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var changeSignUpOrLoginMode: UIButton!
    
    @IBAction func changeSignUpOrLogInMode(_ sender: Any) {
        
        if signUpMode {
            
            signUpOrLogInButton.setTitle("Log In", for: [])
            
            changeSignUpOrLoginMode.setTitle("Sign Up", for: [])
            
            messageLabel.text = "Don't have an account?"
            
            signUpMode = false
            
        } else {
            
            signUpOrLogInButton.setTitle("Sign Up", for: [])
            
            changeSignUpOrLoginMode.setTitle("Log In", for: [])
            
            messageLabel.text = "Already have an account?"
            
            signUpMode = true
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
