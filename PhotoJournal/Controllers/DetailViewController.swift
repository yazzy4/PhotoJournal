//
//  DetailViewController.swift
//  PhotoJournal
//
//  Created by Yaz Burrell on 1/14/19.
//  Copyright © 2019 Yaz Burrell. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var imagePickerViewController: UIImagePickerController!
    private var photoDescriptionPlaceholder = "Photo Description..."
    public var imageIndex = 0
    public var photoArr: PhotoJournal?
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var photoDescription: UITextView!
    @IBOutlet weak var photoImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePickerViewController()
    }
    
    private func setupTextView() {
        photoDescription.delegate = self
        photoDescription.text = photoDescriptionPlaceholder
        photoDescription.textColor = .lightGray

    }
   
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postToFeed(_ sender: Any) {
        guard let photo = photoImage.image?.jpegData(compressionQuality: 0.5),
            let description  = photoDescription.text else {
                 fatalError("no image, no description")
        }
        let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions =  [.withFullDate, .withFullTime, .withInternetDateTime, .withTimeZone, .withDashSeparatorInDate]
        let timestamp = isoDateFormatter.string(from: date)
        
        let post = PhotoJournal.init(createdAt: timestamp, imageData: photo, description: description)
        
        PhotoJournalModel.addPhotos(photos: post)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        imagePickerViewController.sourceType = .camera
        showImagePickerController()
    }
    
    @IBAction func photoLibraryButtonPressed(_ sender: UIBarButtonItem) {
        imagePickerViewController.sourceType = .photoLibrary
        showImagePickerController()
    }
    
    private func showImagePickerController() {
        present(imagePickerViewController, animated: true, completion: nil)
    }
    
    private func setupImagePickerViewController() {
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraButton.isEnabled = false
        }
        if let photoArray  = photoArr {
            photoImage.image = UIImage.init(data: photoArray.imageData)
        }
        
        if let photoArray = photoArr {
            photoDescription.text = photoArray.description
        }
        
        
    }
    private func savePhotoJournal(image: UIImage) {
        //photoJournal: createdAt, description, imageData
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            let photoJournal = PhotoJournal.init(createdAt: "no date", imageData: imageData, description: "cool wallpaper")
            PhotoJournalModel.savePhotoJournal(photoJournal: photoJournal)
        }
    }
    
    
}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImage.image = image
            savePhotoJournal(image: image)
        } else {
            print("original image is nil")
            }
        dismiss(animated: true, completion: nil)
        }
    
    }

extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if photoDescription.text == photoDescriptionPlaceholder {
            textView.text = ""
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            if textView == photoDescription {
                 textView.text = photoDescriptionPlaceholder
                textView.textColor = .lightGray
            }
        }
    }
}


