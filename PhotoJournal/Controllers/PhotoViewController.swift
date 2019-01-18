//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Yaz Burrell on 1/14/19.
//  Copyright © 2019 Yaz Burrell. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photoJournalCollection: UICollectionView!
    


    private var allJournalImages = PhotoJournalModel.getPhotoJournal() {
        didSet {
            photoJournalCollection.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoJournalCollection.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allJournalImages = PhotoJournalModel.getPhotoJournal()
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: {(action ) in
        PhotoJournalModel.deletePost( atIndex: sender.tag)
            self.allJournalImages = PhotoJournalModel.getPhotoJournal()
        })
        let editAction = UIAlertAction(title: "Edit", style: .default, handler: {(action ) in PhotoJournalModel.editPhotos(photos: self.allJournalImages[sender.tag], atIndex: sender.tag)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "editStoryBoard") as? DetailViewController else { return }
            viewController.imageIndex  = sender.tag
            viewController.photoArr = self.allJournalImages[sender.tag]
            self.present(viewController, animated: true, completion: nil)
            
        })
        let shareAction = UIAlertAction(title: "Save", style: .default, handler: {(action ) in
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action ) in })
        
        
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(editAction)
        optionMenu.addAction(shareAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    
    
    
    }
    


extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoJournalModel.getPhotoJournal().count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollection", for: indexPath) as? PhotoCollectionViewCell else {
        fatalError("cell error")
        }
        let photo = allJournalImages[indexPath.row]
        cell.dateLabel.text = photo.dateFormattedString
        cell.photoLabel.text = photo.description
        if let image = UIImage.init(data: photo.imageData){
            cell.image.image = image
        } else{
                fatalError("no image")
        }
        
        return cell
    }
    
}



extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil {
            
        } else {
            print("Original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}



















