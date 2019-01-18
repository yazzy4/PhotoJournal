//
//  PhotoJournalModel.swift
//  PhotoJournal
//
//  Created by Yaz Burrell on 1/15/19.
//  Copyright © 2019 Yaz Burrell. All rights reserved.
//

import Foundation
final class PhotoJournalModel {
    private static let filename = "UIImage.plist"
    
    private static var photoJournals = [PhotoJournal]()

    private init() {}
    
    //photo journal library
    static func savePhotoJournal(photoJournal:  PhotoJournal){
        let path = DataPersistenceManager.filepathToDocumentDirectory(filename: filename)
        do {
            let  data = try PropertyListEncoder().encode(photoJournal)
            try data.write(to: path, options: Data.WritingOptions.atomic)
            
        } catch {
            print("property list encoding error: \(error)")
        }
        
    }
    static func getPhotoJournal() -> [PhotoJournal] {
        let path = DataPersistenceManager.filepathToDocumentDirectory(filename: filename).path
        
        if FileManager.default.fileExists(atPath: path){
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    photoJournals = try PropertyListDecoder().decode([PhotoJournal].self, from: data)
                } catch {
                    print("property list decoding error:\(error)")
                }
            } else {
                print("getPhotoJournal is nil")
            }
        } else {
            print("\(filename)")
        }
        photoJournals = photoJournals.sorted{ $0.date > $1.date}
        return photoJournals
       
    }
    
    static func addPhotos(photos: PhotoJournal) {
        photoJournals.append(photos)
        save()
    }
    
    static func editPhotos(photos: PhotoJournal,  atIndex index: Int) {
        photoJournals.remove(at: index)
        photoJournals.insert(photos, at: index)
        photoJournals.sorted(by: {$0.date > $1.date} )
        save()
    }
    
    static func deletePost(atIndex index: Int) {
        photoJournals.remove(at: index)
        save()
    }
    static func save() {
        let path = DataPersistenceManager.filepathToDocumentDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(photoJournals)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding error: \(error)")
        }
    }

}


