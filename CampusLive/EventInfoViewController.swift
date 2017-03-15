//
//  EventInfoViewController.swift
//  CampusLive
//
//  Created by Mihai Ruber on 3/3/17.
//  Copyright © 2017 Mihai Ruber. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class EventInfoViewController: UIViewController {
    
    var userRef = FIRDatabase.database().reference()
    var uid: String!
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventSubtitle: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var eventProfileImage: UIImageView!
    //@IBOutlet weak var startDate: UILabel!
    //@IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var startDate: UILabel!
    
    var titleEvent: String?
    var subtitleEvent: String?
    var descriptionEvent: String?
    var imageEventUrl: String?
    var startDateStr: String?
    var endDateStr: String?
    var eventId: String?
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = titleEvent
        
        eventTitle?.text = titleEvent
        eventSubtitle?.text = subtitleEvent
        
        eventDescription.text = descriptionEvent
        print(endDateStr)
        startDate.text = endDateStr
        //startDate.isHidden = true
        
        let imageUrl: URL = NSURL(string: imageEventUrl!) as! URL
        
        let data = try? Data(contentsOf: imageUrl)
        
        let profileImage : UIImage = UIImage(data: data!)!
        
        eventProfileImage.image = profileImage
        
        eventProfileImage.layer.cornerRadius = eventProfileImage.frame.size.width / 2
        eventProfileImage.layer.cornerRadius = eventProfileImage.frame.size.height / 2
        eventProfileImage.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reportEventClicked(_ sender: Any) {
        self.uid = FIRAuth.auth()?.currentUser?.uid
        let posts: [String : AnyObject] = ["reported By": uid as AnyObject]
        userRef = userRef.child("malicious_events").child(eventId!)
        userRef.setValue(posts)
        
        let addEventPopup = UIAlertController(title: "Appreciate it!", message: "Thank you for reporting. Our team will shortly look into it.", preferredStyle: .alert)
        addEventPopup.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.dismiss(animated: true, completion: nil)
        }))
        present(addEventPopup, animated: true, completion: nil)
        
    }
    
    
}
