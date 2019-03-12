//
//  ViewController.swift
//  WeChat
//
//  Created by weiphone on 2019/3/8.
//  Copyright © 2019 weiphone. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var userMessages: [UserMessage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configTableView()
        
        textField.delegate = self
        userMessages = UserMessage().findMessage()
        
        NotificationCenter.default.addObserver(self,selector:#selector(keyboardWillChange(_:)),name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
        tableView.register(UINib.init(nibName: "TalkCell", bundle: nil), forCellReuseIdentifier: "TalkCell")
        tableView.register(UINib.init(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "ImageCell")
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetTableViewContentOffset(animated: false)
    }
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @objc func keyboardWillChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
            
        let frame = value.cgRectValue
        
        if #available(iOS 11.0, *) {
            let intersection = view.safeAreaInsets
            var bottom = -(frame.intersection(view.frame).height - intersection.bottom)
            if bottom > 0 {
                bottom = 0
            }
            bottomConstraint.constant = bottom
            tableView.contentOffset = CGPoint(x: 0, y: tableView.contentOffset.y-bottom)
        } else {
            let intersection = frame.intersection(view.frame)
            bottomConstraint.constant = -intersection.height
        }
        
        UIView.animate(withDuration: duration, delay: 0.0,options: UIView.AnimationOptions(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        },completion: nil)
    }
    
    // UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count > 0 else { return false }
        let userMessage = UserMessage()
        userMessage.name = "Acan"
        userMessage.text = textField.text
        userMessage.insertMessage(userMessage)
        userMessages = userMessage.findMessage()
        tableView.reloadData()
        textField.text = nil
        textField.endEditing(true)
        resetTableViewContentOffset(animated: true)
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
            cell.selectionStyle = .none
            return cell
        } else if userMessages[indexPath.row].name == "Linder" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TalkCell") as! TalkCell
            cell.userMessage = userMessages[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
            cell.userMessage = userMessages[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        textField.endEditing(true)
    }
    
    @IBAction func sendOtherMessage(_ sender: Any) {
        let userMessage = UserMessage()
        userMessage.name = "Linder"
        userMessage.text = "你好！!"
        userMessage.insertMessage(userMessage)
        userMessages = userMessage.findMessage()
        
        print("identifier: \(userMessage.lastInsertedRowID))")
        
        tableView.reloadData()
        resetTableViewContentOffset(animated: false)
    }
    
    @IBAction func deleteAllMessage(_ sender: Any) {
        let userMessage = UserMessage()
        userMessage.deleteMessage()
        userMessages = userMessage.findMessage()
        tableView.reloadData()
    }
    
    // 发送图片
    @IBAction func sendImageMessage(_ sender: Any) {
        let imageVc = UIImagePickerController()
        imageVc.sourceType = .photoLibrary
        imageVc.delegate = self
        self.present(imageVc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) {
            let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            let imageData = image?.pngData()
            let userMessage = UserMessage()
            userMessage.imageData = imageData
            userMessage.insertMessage(userMessage)
            self.userMessages = userMessage.findMessage()
            self.tableView.reloadData()
            self.resetTableViewContentOffset(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func resetTableViewContentOffset(animated: Bool) {
        tableView.scrollToRow(at: IndexPath(row: userMessages.count - 1, section: 0), at: .bottom, animated: animated)
    }
}

