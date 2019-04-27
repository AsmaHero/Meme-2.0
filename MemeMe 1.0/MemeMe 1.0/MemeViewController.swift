//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Asmahero on ٧ شعبان، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Asmahero. All rights reserved.
import UIKit



class MemeViewController: UIViewController ,UINavigationControllerDelegate , UIImagePickerControllerDelegate,  UITextFieldDelegate
{
 
    
    @IBOutlet weak var album: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var Camera: UIBarButtonItem!
    @IBOutlet weak var TOP: UITextField!
    @IBOutlet weak var BOTTOM: UITextField!
    @IBOutlet weak var Share: UIBarButtonItem!
    @IBOutlet weak var Cancel: UIBarButtonItem!

    @IBOutlet weak var  Navigationbar: UINavigationItem!
    
    @IBOutlet weak var ToolBar: UIToolbar!
    var textField :UITextField!
    var memedImage :UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        // TO initialize a TEXTFIELD
        textFieldInitilize(TOP,"TOP")
        textFieldInitilize(BOTTOM,"BOTTOM")
        // TO initialize image
        initialImage()
        Share.isEnabled = false
    }
    
    // TO initialize an initial image for layout purpose
    func initialImage ()
    {
        // put inintial image
        imagePickerView.image = UIImage(named: "upload")!
    }
   
    // TO initilize textfield for both bottom and top
    func textFieldInitilize (_ tf: UITextField ,_ TEXT : String)
    {
        // refer to delegate members
        self.TOP.delegate = self
        self.BOTTOM.delegate = self
        
        let memeTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.white,NSAttributedString.Key.strokeColor.rawValue : UIColor.black, NSAttributedString.Key.font.rawValue : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,NSAttributedString.Key.strokeWidth.rawValue: -4.0,]as! [NSAttributedString.Key : Any]
        Share.isEnabled = false
        tf.defaultTextAttributes = memeTextAttributes
        tf.textColor = UIColor.white
        tf.tintColor = UIColor.white
        tf.textAlignment = .center
        tf.text = TEXT
        tf.delegate = self
    }
    // MARK: Text Field Delegate
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
        if(textField.text == "TOP" || textField.text == "BOTTOM") {
            textField.text = ""
        }
        
    }
    // When a user presses return, the keyboard should be dismissed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    // when the interface will appear these are the process will happend
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        //calling keyboard notification method
        subscribeToKeyboardNotifications()
        // disable the camera button in cases when this bool returns false for the camera sourceType because the simulators does not have a camera
       Camera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }
     // when the interface will disappear these are the process will happend
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // to unsubscribe and back to normal situation
        unsubscribeFromKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pick (_ sender: Any)
    {
        let imagePicker = UIImagePickerController()

        imagePicker.delegate = self
        if let sender = album as? UIBarButtonItem {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        }
        else
        {
         imagePicker.sourceType = UIImagePickerController.SourceType.camera
        }
      
        present(imagePicker, animated: true, completion: nil)
     
    }
    
     //MARK: - Delegates
    // to take the image from the picker and put it in place of the image if finish with picking media
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePickerView.image = image
            Share.isEnabled = true
        }
     else {
    print("Something went wrong")
    }
        self.dismiss(animated: true, completion: nil)
    }
    // to get the keyboard height
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    // to make sure the keyboard not cover the text field by moving it to the bottom of the field
    @objc  func keyboardWillShow(_ notification:Notification) {
        if self.BOTTOM.isEditing{
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
// back  the frame of keyboard to normal situation
    @objc func keyboardWillBeHide(note: Notification) {
        view.frame.origin.y = 0
    }
    //calling function when the keyboard will show or hide
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHide(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
   
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
 func save() {
    // Create the meme
    memedImage = generateMemedImage()
    let meme = Meme(top: TOP.text!, bottom: BOTTOM.text!, image: imagePickerView.image!, memedImage: generateMemedImage())
    
    // Add it to the memes array in the Application Delegate
   (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)

    }
    
    // to hide the toolbar and navigation bar then save the correct memed image without any extra
    func generateMemedImage() -> UIImage {
           // TODO: Hide toolbar and navbar
        ToolBar.isHidden = true
        self.Navigationbar.leftBarButtonItem?.isEnabled = true
        self.Navigationbar.rightBarButtonItem?.isEnabled = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
         // TODO: Show toolbar and navbar
      ToolBar.isHidden = false
        self.Navigationbar.leftBarButtonItem?.isEnabled = false
        self.Navigationbar.rightBarButtonItem?.isEnabled = false
        return memedImage
    }
    // take the memed image to save it or share
    @IBAction func Share(_ sender: Any) {
        //present activity view for the memed image
        let sharedImage = generateMemedImage()
        
        // generate the memed image
        let activityController = UIActivityViewController(activityItems:    [sharedImage], applicationActivities: nil)
        activityController.completionWithItemsHandler = { activity, completed, items, error in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        self.present(activityController, animated: true, completion: nil)

    }
    // this when I want to BACK EVERY THING TO NORMAL
    @IBAction func dismiss(_ sender: Any) {
      
      textFieldInitilize(TOP, "TOP")
        textFieldInitilize(BOTTOM, "BOTTOM")
        initialImage()
        self.dismiss(animated: true, completion: nil)
    }
}
    


