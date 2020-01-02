//
//  FirstViewController.swift
//  CoreDataDB
//
//  Created by A RAJU on 12/21/19.
//  Copyright © 2019 A RAJU. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    

     var managedObject:NSManagedObjectContext!
     var appDelegate:AppDelegate!
     var perosonDetailsEntity:NSEntityDescription!
  
  var imageData:NSData!
  var imagePicker = UIImagePickerController()
  

  var name:UITextField!
  var age:UITextField!
  var email:UITextField!


  var imageButton:UIButton!
  
  var submitButton:UIButton!
  

    
  @IBOutlet weak var contentView: UIView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
// calling the function
        
       coreDataCreate()
        uiDiplayPath()
        
   

    }
    
      func uiDiplayPath(){
        
        
        // creating the image button
            

          imageButton = UIButton()
          imageButton.frame = CGRect(x: 110, y: 50, width: 200, height: 200)
          imageButton.setBackgroundImage(UIImage(named: "defaultProfile"), for: UIControl.State.normal)
          imageButton.layer.cornerRadius = imageButton.frame.size.width/2
          imageButton.clipsToBounds = true
          imageButton.addTarget(self, action: #selector(imageButtonActionc(object:)), for: UIControl.Event.touchUpInside)
          contentView.addSubview(imageButton)


          // creating the textfield

             name = UITextField()
             name.frame = CGRect(x: 100, y: 320, width: 200, height: 50)
             name.placeholder = "Name"
             name.textColor = .white
             contentView.addSubview(name)

             age = UITextField()
             age.frame = CGRect(x: 100, y: 400, width: 200, height: 50)
           
             age.placeholder = "Age"
             age.textColor = .white
           
             contentView.addSubview(age)

             email = UITextField()
             email.frame = CGRect(x: 100, y: 480, width: 200, height: 50)
         
             email.textColor = .white
             email.placeholder = "Email"
             contentView.addSubview(email)
             
        // creating the submit button
        
             submitButton = UIButton()
             submitButton.frame = CGRect(x: 140, y: 570, width: 100, height: 50)
             submitButton.backgroundColor = .systemBlue
             submitButton.setTitle("SUBMIT", for: UIControl.State.normal)
             submitButton.layer.cornerRadius = submitButton.frame.size.width/6
             submitButton.clipsToBounds = true
             submitButton.addTarget(self, action: #selector(saveButton), for: UIControl.Event.touchUpInside)
             contentView.addSubview(submitButton)
          
            }
    
    
             @objc func imageButtonActionc(object:Any){
                if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum)){

               imagePicker.delegate = self
               imagePicker.sourceType = .savedPhotosAlbum
               imagePicker.allowsEditing = true
                
              self.present(imagePicker, animated: true, completion: nil)
                    print("image selected")
            }
       }
    
    
    
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {

          if  let pickedImage:UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage{

              imageButton.setImage(pickedImage, for: UIControl.State.normal)
            self.imageData = pickedImage.pngData() as NSData?

          }

         dismiss(animated: true, completion: nil)
      }

      func coreDataCreate(){

          appDelegate = (UIApplication.shared.delegate as! AppDelegate)

          managedObject = appDelegate.persistentContainer.viewContext

          perosonDetailsEntity = NSEntityDescription.entity(forEntityName: "PersonDetails", in: managedObject)
        
      }
    // event handler for save button
      @objc func saveButton(){
        
          let personMO = NSManagedObject(entity: perosonDetailsEntity!, insertInto: managedObject)

         let vaule1 =  personMO.setValue(name.text!, forKey: "name")
          let ageP = Int(age.text!)

          personMO.setValue(ageP, forKey: "age")

          personMO.setValue(email.text!, forKey: "email")
        
            personMO.setValue(imageData, forKey: "imageData")
        
          do
          {
              try managedObject.save()
          }
          catch
          {
              print("Catch Erroe : Failed To ave")
          }
        
            navigationController?.popViewController(animated: true)

      }
      
    
}


