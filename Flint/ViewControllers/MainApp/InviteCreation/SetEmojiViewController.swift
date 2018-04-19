//
//  SetEmojiViewController.swift
//  Flint
//
//  Created by MILAD on 4/19/18.
//  Copyright © 2018 MILAD. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift
import ISEmojiView
import Alamofire
import CodableAlamofire


class SetEmojiViewController: UIViewController ,ISEmojiViewDelegate{

    @IBOutlet weak var inviteTitle: UILabel!
    
    @IBOutlet weak var inviteNumber: UILabel!
    
    @IBOutlet weak var invitePosition: UILabel!
    
    @IBOutlet weak var inviteTime: UILabel!
    
    @IBOutlet weak var emojiTextView: UITextView!
    
    @IBOutlet weak var pinImage: UIImageView!
    
    var page : Int = 1
    
    
    let emojiView = ISEmojiView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emojiView.delegate = self
        
        emojiTextView.inputView = emojiView
        
        self.inviteTitle.text = GlobalFields.inviteTitle
        self.inviteTitle.layer.borderWidth = 1
        self.inviteTitle.layer.borderColor = GlobalFields.inviteMoodColor?.cgColor
        self.inviteTitle.backgroundColor = UIColor.clear
        
        inviteNumber.text = (GlobalFields.inviteNumber?.description)! + " person"
        
        invitePosition.text = GlobalFields.inviteAddress
        
        let w = GlobalFields.inviteWhen
        if(w == 0){
            self.inviteTime.text = "Right now"
        }else{
            let date : Date = Date().addingTimeInterval(Double(w!) * 60.0 * 30.0)
            let dateFormatterGet : DateFormatter = DateFormatter()
            dateFormatterGet.dateFormat = "HH:mm"
            self.inviteTime.text = dateFormatterGet.string(from: date)
        }
        
        switch GlobalFields.inviteMood! {
        case "LetsSeeWhatHappens":
            self.pinImage.image = UIImage.init(named: "pin_pink")
        case "Friendly":
            self.pinImage.image = UIImage.init(named: "pin_yellow")
        case "Business":
            self.pinImage.image = UIImage.init(named: "pin_gray")
        default:
            self.pinImage.image = UIImage.init(named: "pin_blue")
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.inviteTitle.layer.cornerRadius = self.inviteTitle.frame.height / 2
        self.inviteTitle.layer.backgroundColor = GlobalFields.inviteMoodColor?.cgColor
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func next(_ sender: Any) {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        var type : Int = 0
        
        switch GlobalFields.inviteMood! {
        case "LetsSeeWhatHappens":
            type = 0
        case "Friendly":
            type = 1
        case "Business":
            type = 2
        default:
            type = 3
        }
        
        let date : Date = Date().addingTimeInterval(Double(GlobalFields.inviteWhen!) * 60.0 * 30.0)
        
        request(URLs.createInvitation, method: .post , parameters: CreateInvitationRequestModel.init(type: type, lat: (GlobalFields.inviteLocation?.latitude.description)!, long: (GlobalFields.inviteLocation?.longitude.description)!, peopleCount: GlobalFields.inviteNumber!, exactTime: Int(date.timeIntervalSince1970), when: GlobalFields.inviteWhen!, emoji: GlobalFields.inviteEmoji!, title: GlobalFields.inviteTitle!).getParams() , headers : ["Content-Type": "application/x-www-form-urlencoded"] ).responseDecodableObject(decoder: decoder) { (response : DataResponse<ResponseModel<CreateInviteRes>>) in
            
            let res = response.result.value
            
            if(res?.status == "success"){
                
                request(URLs.getUsersListForInvite, method: .post , parameters: GetUsersListForInviteRequestModel.init(invite: (res?.data?.invite)!, page: 1, perPage: 10, lat: (GlobalFields.inviteLocation?.latitude.description)!, long: (GlobalFields.inviteLocation?.longitude.description)!).getParams() , headers : ["Content-Type": "application/x-www-form-urlencoded"] ).responseDecodableObject(decoder: decoder) { (response : DataResponse<ResponseModel<[GetUserListForInviteRes]>>) in
                    
                    let res = response.result.value
                    
                    let vC : MainInvitationViewController = (self.storyboard?.instantiateViewController(withIdentifier: "MainInvitationViewController"))! as! MainInvitationViewController
                    if(res?.data != nil){
                        vC.usersList = (res?.data)!
                        self.navigationController?.pushViewController(vC, animated: true)
                    }else{
                        //TODO : bayad alert bedim k kasi nis doret
                        return
                    }
                }
                
            }
            
        }
        
    }
    
    @IBAction func goProfile(_ sender: Any) {
        let vC : MainProfileViewController = (self.storyboard?.instantiateViewController(withIdentifier: "MainProfileViewController"))! as! MainProfileViewController
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func goMessaging(_ sender: Any) {
        let vC : MainProfileViewController = (self.storyboard?.instantiateViewController(withIdentifier: "MainProfileViewController"))! as! MainProfileViewController
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // callback when tap a emoji on keyboard
    func emojiViewDidSelectEmoji(emojiView: ISEmojiView, emoji: String) {
        emojiTextView.text = ""
        emojiTextView.insertText(emoji)
        GlobalFields.inviteEmoji = emojiTextView.text
        dismiss("")
    }
    
    // callback when tap delete button on keyboard
    func emojiViewDidPressDeleteButton(emojiView: ISEmojiView) {
        emojiTextView.deleteBackward()
    }
    
}
