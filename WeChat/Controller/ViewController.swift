//
//  ViewController.swift
//  WeChat
//
//  Created by weiphone on 2019/3/8.
//  Copyright © 2019 weiphone. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var userMessages: [UserMessage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
        tableView.register(UINib.init(nibName: "TalkCell", bundle: nil), forCellReuseIdentifier: "TalkCell")
        tableView.tableFooterView = UIView(frame: .zero)
        
        userMessages = UserMessage().findMessage()
        
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
    
    // UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let userMessage = UserMessage()
        userMessage.name = "Acan"
        userMessage.text = textField.text
        userMessage.insertMessage(userMessage)
        userMessages = userMessage.findMessage()
        
        print("identifier: \(userMessage.lastInsertedRowID))")
        
        tableView.reloadData()
        textField.resignFirstResponder()
        return true
    }
    
    // UITablViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if userMessages[indexPath.row].name == "Acan" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
            cell.userMessage = userMessages[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TalkCell") as! TalkCell
            cell.userMessage = userMessages[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    @IBAction func sendOtherMessage(_ sender: Any) {
        let userMessage = UserMessage()
        userMessage.name = "Linder"
        userMessage.text = "你好！!"
        userMessage.insertMessage(userMessage)
        userMessages = userMessage.findMessage()
        
        print("identifier: \(userMessage.lastInsertedRowID))")
        
        tableView.reloadData()
    }
    
}

