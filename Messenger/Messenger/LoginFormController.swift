//
//  ViewController.swift
//  Messenger
//
//  Created by Polly on 17.12.2021.
//

import UIKit

class LoginFormController: UIViewController {

    // DEPRICATED
   
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
     
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
     
    override func viewDidLoad() {
        super.viewDidLoad()

        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
    }
     
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    
    
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    
    @objc func keyboardWillBeHidden(notification: Notification) {
         
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    
    func checkUserData() -> Bool {
        guard let login = loginTextField.text,
              let password = passwordTextField.text else {
                print("Неуспешная авторизация")
                return false }
        
        if login == "admin" && password == "123456" {
            print("Успешная авторизация")
            return true
        } else {
           // print("Неуспешная авторизация")
           
           // change return false
            return true
        }
    }
    
    func showLoginError() {
        let alert = UIAlertController(title: "Error", message: "Некорректный ввод", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if checkUserData() { return true }
        showLoginError()
        return false
    }
   
}

