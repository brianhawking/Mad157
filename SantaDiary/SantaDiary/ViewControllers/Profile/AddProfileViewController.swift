//
//  AddProfileViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/18/21.
//

import UIKit



class AddProfileViewController: UIViewController, UINavigationControllerDelegate {

    
    @IBOutlet weak var profileDetailsView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextView: UITextField!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    let dateFormatter: DateFormatter = DateFormatter()
    var imageNumber = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        birthdayDatePicker.setValue(UIColor.white, forKeyPath: "textColor")
//        birthdayDatePicker.setValue(false, forKeyPath: "highlightsToday")
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
//        birthdayDatePicker.preferredDatePickerStyle = .wheels
        
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
        else if (imageNumber == -1) {
            print("Choose a photo")
            return
        }
        // create profile
        createProfile()
    }
    
    
    func createProfile() {
        
        let profile = ProfileEntry(
            name: nameTextView.text!,
            image: SantaImages().avatar[imageNumber],
            birthDay: birthdayDatePicker.date)
        
        if (ProfileManager().createProfile(profile: profile)) {
            // profile created
            print("Profile directory created")
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
        print(info)
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.avatarImageView.image = selectedImage
    }
}
