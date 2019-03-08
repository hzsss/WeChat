//
//  ViewController.swift
//  WeChat
//
//  Created by weiphone on 2019/3/8.
//  Copyright © 2019 weiphone. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField.delegate = self
        
    NotificationCenter.default.addObserver(self,selector:#selector(keyboardWillChange(_:)),name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @objc func keyboardWillChange(_ notification: Notification) {
        if let userInfo = notification.userInfo,
            let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            
            let frame = value.cgRectValue
            
            if #available(iOS 11.0, *) {
                let intersection = self.view.safeAreaInsets
                var test = -(frame.intersection(self.view.frame).height - intersection.bottom)
                if test > 0 {
                    test = 0
                }
                self.bottomConstraint.constant = test
            } else {
                let intersection = frame.intersection(self.view.frame)
                self.bottomConstraint.constant = -intersection.height
            }
            
            UIView.animate(withDuration: duration, delay: 0.0,options: UIView.AnimationOptions(rawValue: curve), animations: {
                self.view.layoutIfNeeded()
            },completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.endEditing(true)
    }
}

