//
//  EditProfileViewController.swift
//  Flint
//
//  Created by MILAD on 4/18/18.
//  Copyright © 2018 MILAD. All rights reserved.
//

import UIKit
import Alamofire
import CodableAlamofire
import Gallery
import UIColor_Hex_Swift
import IGRPhotoTweaks
import Kingfisher

class EditProfileViewController: UIViewController ,UIScrollViewDelegate ,GalleryControllerDelegate , IGRPhotoTweakViewControllerDelegate{

    
    @IBOutlet weak var img1Button: UIButton!
    @IBOutlet weak var img2Button: UIButton!
    @IBOutlet weak var bioText: UITextView!
    @IBOutlet weak var myJob: UITextField!
    @IBOutlet weak var myStudies: UITextField!
    @IBOutlet weak var sex: UITextField!
    @IBOutlet weak var viewInScrollView: UIView!
    @IBOutlet weak var scroller: UIScrollView!
    var isCHangedImg1 : Bool = false
    var isCHangedImg2 : Bool = false
    var isUPloadedImg1 : Bool = false
    var isUploadedImg2 : Bool = false
    var whichImg : Int = 0
    var cropVC = IGRPhotoTweakViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scroller.delegate = self
        scroller.contentSize = CGSize(width: self.view.frame.width, height: 890 * self.view.frame.height / 667)
        
        //avatara set shan
        self.bioText.text = GlobalFields.loginResData?.bio
        self.myJob.text = GlobalFields.loginResData?.job
        self.myStudies.text = GlobalFields.loginResData?.studies
        self.sex.text = GlobalFields.loginResData?.gender
        
        self.img1Button.kf.setBackgroundImage(with: URL(string: URLs.imgServer + (GlobalFields.loginResData?.avatar)!), for: .normal)
        self.img2Button.kf.setBackgroundImage(with: URL(string: URLs.imgServer + (GlobalFields.loginResData?.second_avatar)!), for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func setChanged(_ sender: Any) {
        
        if(isCHangedImg1){
            self.uploadImage(img: self.img1Button.backgroundImage(for: .normal)!, whichAvatar: 1)
        }
        if(isCHangedImg2){
            self.uploadImage(img: self.img2Button.backgroundImage(for: .normal)!, whichAvatar: 2)
        }
        
    }
    
    
    @IBAction func clickImg1(_ sender: Any) {
        self.whichImg = 1
        let gallery = GalleryController()
        gallery.delegate = self
        Config.Camera.recordLocation = false
        Config.tabsToShow = [.imageTab]
        present(gallery, animated: true, completion: nil)
    }
    
    @IBAction func clickImg2(_ sender: Any) {
        self.whichImg = 2
        let gallery = GalleryController()
        gallery.delegate = self
        Config.Camera.recordLocation = false
        Config.tabsToShow = [.imageTab]
        present(gallery, animated: true, completion: nil)
    }
    
    
    func uploadImage(img : UIImage , whichAvatar : Int){
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(UIImagePNGRepresentation(img)!, withName: Date().description, fileName: Date().description + ".png", mimeType: "image/png")
        }, to: URLs.uploadImage)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                upload.responseDecodableObject(decoder: decoder) { (response : DataResponse<ResponseModel<UploadImageRes>>) in
                    
                    let res = response.result.value
                    
                    if(res?.status == "success"){
                        if(whichAvatar == 1){
                            GlobalFields.userInfo.AVATAR = res?.data?.name
                            self.isUPloadedImg1 = true
                            self.callEditIngo()
                        }else if(whichAvatar == 2){
                            GlobalFields.userInfo.SECOND_AVATAR = res?.data?.name
                            self.isUploadedImg2 = true
                            self.callEditIngo()
                        }
                    }
                    
                    
                }
                
            case .failure(let encodingError):
                //self.delegate?.showFailAlert()
                print(encodingError)
            }
            
        }
    }
    
    
    func callEditIngo(){
        
        if(isCHangedImg1 && isUPloadedImg1 != false){
            return
        }
        if(isCHangedImg2 && isUploadedImg2 != false){
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        var gen : String = ""
        if(sex.text == "man" || sex.text == "male"){
            gen = "male"
        }else{
            gen = "female"
        }
        
        request(URLs.editUserInfo, method: .post , parameters: EditUserInformationRequestModel.init(name: nil, birthdate: nil, gender: gen, bio: self.bioText.text, avatar: GlobalFields.userInfo.AVATAR, secAvatar: GlobalFields.userInfo.SECOND_AVATAR, lookingFor: nil, selfie: nil, job: self.myJob.text, studies: self.myStudies.text).getParams() , headers : ["Content-Type": "application/x-www-form-urlencoded"] ).responseDecodableObject(decoder: decoder) { (response : DataResponse<ResponseModel<LoginRes>>) in
            
            let res = response.result.value
            if(res?.status == "success"){
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
        
    }
    
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        print("cancel")
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Gallery.Image]) {
        controller.dismiss(animated: true, completion: nil)
        print("select image")
        
        images[0].resolve{ image in
            let cropViewController = IGRPhotoTweakViewController()
            cropViewController.image = image
            cropViewController.delegate = self
            self.cropVC.delegate = self
            cropViewController.setCropAspectRect(aspect: "200:200")
            cropViewController.lockAspectRatio(true)
            let button = UIButton(type: .system) // let preferred over var here
            button.frame = CGRect.init(x: self.view.frame.width - 100, y: self.view.frame.height - 100, width: 100, height: 100)
            button.layer.cornerRadius = 50
            button.backgroundColor = UIColor.red
            button.setTitle("Mili", for: .normal)
            button.tag = 777
            button.addTarget(self, action: #selector(self.cropAction), for: UIControlEvents.touchUpInside)
            cropViewController.view.addSubview(button)
            self.cropVC = cropViewController
            self.navigationController?.pushViewController(self.cropVC, animated: true)
        }
        
    }
    
    @objc func cropAction(){
        self.cropVC.cropAction()
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Gallery.Image]) {
        print("request light box")
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        print("select video")
        
    }
    
    
    
    func photoTweaksController(_ controller: IGRPhotoTweakViewController, didFinishWithCroppedImage croppedImage: UIImage) {
        if(self.whichImg == 1){
            self.img1Button.setBackgroundImage(croppedImage, for: .normal)
            self.isCHangedImg1 = true
        }else if(self.whichImg == 2){
            self.img2Button.setBackgroundImage(croppedImage, for: .normal)
            self.isCHangedImg2 = true
        }
        _ = controller.navigationController?.popViewController(animated: true)
        
    }
    
    func photoTweaksControllerDidCancel(_ controller: IGRPhotoTweakViewController) {
        _ = controller.navigationController?.popViewController(animated: true)
    }
    
}
