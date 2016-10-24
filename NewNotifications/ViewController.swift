//
//  ViewController.swift
//  NewNotifications
//
//  Created by Marlon Raschid Tavarez Parra on 24/10/16.
//  Copyright © 2016 MyBCloud. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Request Permission
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            
            if granted {
                
                print("Notification access granted")
            }
            else {
                
                print("Error: \(error?.localizedDescription)")
                
            }
            
        }
    }
    
    @IBAction func notifyButtonTapped(_ sender: UIButton) {
        
        sheduleNotification(inSeconds: 5) { (success) in
            
            if success {
                
                print("All OK")
            }
            else {
                
                print("Error schudele Nitification")
            }
            
        }
    }
    
    
    func sheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
        let myImage = "next_episode"
        
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "jpg") else {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        
        
        let notif = UNMutableNotificationContent()
        
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "New Notification"
        notif.subtitle = "These are great!!!!"
        notif.body = "The New Notification in iOS 10 are amazing really great"
        
        notif.attachments = [attachment]
        
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print(error)
                completion(false)
            }else {
                completion(true)
            }
            
        }
        
    }
    

}

