//
//  CameraViewController.swift
//  together
//
//  Created by Rageeb Mahtab on 9/22/19.
//  Copyright © 2019 Helal. All rights reserved.
//

import UIKit
import VisualRecognitionV3
import Parse
import Firebase
import FirebaseStorage

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

@IBOutlet weak var cameraButton: UIBarButtonItem!

//    let api = new ParseServer({
//    ...,
//    // Make sure to define liveQuery AND classNames
//    liveQuery: {
//    // define your ParseObject names here
//    classNames: ["Post", "Comment"]
//    }
//    });
let imagePicker = UIImagePickerController()
let apiKey = "Ds4JDPZjfbNkp5uza69B73OSMzDhbAu7-oDWPV70ChiN"
let version = "2019-09-21"


@IBOutlet weak var imageView: UIImageView!
override func viewDidLoad() {
super.viewDidLoad()
imagePicker.delegate = self
// Do any additional setup after loading the view.
}

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
    imageView.image = image
    imagePicker.dismiss(animated: true, completion: nil)
    
    let visualRecognition = VisualRecognition(version: version, apiKey: apiKey)
//    let classifierID = "your-classifier-ID-here"
//    let threshold = 0.8
//
//    // Classify your image using your model
//    visualRecognition.classify(image: image, threshold: threshold, classifierIDs: [classifierID]) { classifiedImages, error in
//        if let error = error {
//            print(error)
//        }
//        guard let classifiedImages = classifiedImages else {
//            print("Failed to classify the image")
//            return
//        }
//        print(classifiedImages)
//    }
    var data = Data()
    data = image.jpegData(compressionQuality:  0.8)!
    let imageRef = Storage.storage().reference().child("images/" + "25")
    _ = imageRef.putData(data, metadata: nil) {(metadata, error) in
        guard let metadata = metadata else {
            return
        }
        
//            let starsRef = storageRef.child("images/stars.jpg")
//
//            // Fetch the download URL
//            starsRef.downloadURL { url, error in
//                if let error = error {
//                    // Handle any errors
//                } else {
//                    // Get the download URL for 'images/stars.jpg'
//                }
//            }
//            print(downloadURL)
//            print(metadata)
        

//        }
//
//        }
//





//            let imageData = image.jpegData(compressionQuality: 0.8)
//            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//            let fileURL = documentsURL.appendingPathComponent("tempImg.jpg")
//            try? imageData?.write(to: fileURL, options: [])
    //            visualRecognition.classify
    //
    //            if (picker.sourceType == UIImagePickerController.SourceType.camera) {
//            print(image)
//            let post = PFObject(className: "Posts")
//            let img = imageView.image!.pngData()!
//            let file = PFFileObject(data: img)
//            post["image"] = file
//
//            post.saveInBackground { (success, error) in
//                if success {
//                    print("saved")
//                }else {
//                    print("error")
//                }
//
//            }

    //
    
    let url = "https://images.unsplash.com/photo-1569048341367-8e960178ef44?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"
//        let url = imageRef
        visualRecognition.classify(url: url) { response, error in
            if let error = error {
                print(error)
            }
            guard let classifiedImages = response?.result else {
                print("Failed to classify the image")
                return
            }
            if let classification = classifiedImages.images.first?.classifiers.first?.classes.first?.className {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Toilet Paper"
                }
            }
        }
        
        let storage = Storage.storage()
        var reference: StorageReference = storage.reference(forURL: "gs://together-26fdb.appspot.com/")
        reference.downloadURL { (url, error) in
            //using a guard statement to unwrap the url and check for error
            guard let imageURL = url, error == nil else {
                //handle error here if returned url is bad or there is error
                return
            }
            guard let data = NSData(contentsOf: imageURL) else {
                //same thing here, handle failed data download
                return
            }
            let img = UIImage(data: data as Data)
            
//            visualRecognition.classify(image: image, completionHandler: { response, error in
//                //                print(imageView)
//                if let error = error {
//                    print("error")
//                }
//                print(response?.result)
//                //                guard let classifiedImages = response?.result else {
//                //                    print("Failed to classify the image")
//                //                    return
//                //                }
//                //                let classes = classifiedImages.images.first!.classifiers.first!.classes
////                print(response?.result)
//
//                //                print(classes)
//            })
            
            
            
        }
    //            imageView.image!



//    }
//    else {
//            print("There was an error")
//        }
//    } else {
//        print("There was an error")
//    }
    }
}




/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
// Get the new view controller using segue.destination.
// Pass the selected object to the new view controller.
}
*/



}
    
    
    @IBAction func cameraPressed(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}
