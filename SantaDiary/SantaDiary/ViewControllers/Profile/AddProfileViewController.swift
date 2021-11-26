//
//  AddProfileViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/18/21.
//

import UIKit



class AddProfileViewController: UIViewController, UINavigationControllerDelegate {

    var profile = ProfileEntry(name: "", image: "", birthDay: Date())
    
    @IBOutlet weak var profileDetailsView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextView: UITextField!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    
    var isImageSelected = false
    
    let dateFormatter: DateFormatter = DateFormatter()
    var imageNumber = -1
    var customImage: UIImage = UIImage(named: SantaImages().avatar[0])!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        avatarImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changeProfilePicture))
        gesture.numberOfTouchesRequired = 1
        avatarImageView.addGestureRecognizer(gesture)
        
//        avatarImageView.layer.cornerRadius = avatarImageView.frame.width/2
        
        profileDetailsView.layer.cornerRadius = 10
    }
    
    @objc func changeProfilePicture() {
        print("Let's change pic")
        presentPhotoActionSheet()
    }
    
   
    
    @IBAction func saveButton(_ sender: Any) {
        if (nameTextView.text == "") {
            print("Enter a name")
            return
        }
        else if (isImageSelected == false) {
            print("Choose a photo")
            return
        }
        // create profile
        createProfile()
    }
    
    
    func createProfile() {
        
        if (imageNumber == -1) {
            // user chose a custom image
            
            profile.name = nameTextView.text!
            profile.image = "profilePic.png"
            profile.birthDay = birthdayDatePicker.date
            
        }
        else {
            // user chose a premade image
            profile.name = nameTextView.text!
            profile.image = SantaImages().avatar[imageNumber]
            profile.birthDay = birthdayDatePicker.date
            
        }
        
        
        if (ProfileManager().createProfile(profile: profile)) {
            // profile created
            
            if (imageNumber == -1) {
                let data = customImage.pngData()! as NSData

                let path = FileManager.default.urls(
                    for: .documentDirectory, in: .userDomainMask)[0]
                    .appendingPathComponent("Users")
                    .appendingPathComponent(profile.name)
                    .appendingPathComponent("profilePic.png")
                
                data.write(toFile: path.path, atomically: false)

                if(data.write(toFile: path.path, atomically: true)) {
                    print("Image successfully saved")
                } else {
                    print("image not saaved")
                }
                let photoURL = URL.init(fileURLWithPath: path.path)
                print(photoURL)
            }
            
            
            self.navigationController?.popViewController(animated: true)
        }
        else {
            // profile not created
            print("something went wrong with creating the profile diretory")
        }
        
    }
}

extension AddProfileViewController: UIImagePickerControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Premade Avatars", style: .default, handler: { [weak self] _ in
            self?.presentAvatarViewController()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "From album", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentAvatarViewController() {
        performSegue(withIdentifier: "toAvatarsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toAvatarsSegue") {
            let controller = segue.destination as! SelectAvatarCollectionViewController
            
            controller.completionHandler = { image in
                // update image
                self.imageNumber = image
                self.isImageSelected = true
                self.avatarImageView.image = UIImage(named: SantaImages().avatar[image])
            }
        }
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
        
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        imageNumber = -1
        isImageSelected = true
        
        customImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
//        let data = customImage.pngData()! as NSData
//        
//        // temporary save in users folder
//        let path = FileManager.default.urls(
//            for: .documentDirectory, in: .userDomainMask)[0]
//            .appendingPathComponent("Users")
//            .appendingPathComponent("profilePic.png")
//        
//        if(data.write(toFile: path.path, atomically: true)) {
//            print("Image successfully saved")
//        } else {
//            print("image not saved")
//        }
//        
//        let photoURL = URL.init(fileURLWithPath: path.path)
//        
//        print(photoURL)

        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.avatarImageView.image = selectedImage
        
        
    }
}
