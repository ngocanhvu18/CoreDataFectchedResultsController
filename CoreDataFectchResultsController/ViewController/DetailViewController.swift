//
//  ViewController.swift
//  CoreDataFectchResultsController
//
//  Created by NgocAnh on 5/24/18.
//  Copyright © 2018 NgocAnh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var entity: Entity?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configure(){
        if entity != nil {
            nameTextField.text = entity?.name
            ageTextField.text = String(entity?.age ?? 0)
            imageView.image = entity?.photo as? UIImage
        }
    }
    // chọn ảnh
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present( imagePickerController , animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let masterViewController = segue.destination as? MasterViewController {
            var ageNewValue: Int?
            if ageTextField.text != "" {
                ageNewValue = Int(ageTextField.text ?? "")
            }
            if masterViewController.tableView.indexPathForSelectedRow == nil {
                // NewValue
                entity = Entity(context: AppDelegate.context)
            }
            entity?.age = Int32(ageNewValue!)
            entity?.name = nameTextField.text
            entity?.photo = imageView.image
            DataService.share.saveToCoreData()
        }
    }
    
}



