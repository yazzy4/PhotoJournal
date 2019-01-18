//
//  DataPersistenceManager.swift
//  PhotoJournal
//
//  Created by Yaz Burrell on 1/15/19.
//  Copyright © 2019 Yaz Burrell. All rights reserved.
//

import Foundation

final class DataPersistenceManager {
    private static let filename = "UIImage.plist"
    //paths to documents directory
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
    }
    
    //filepath using filename to documents direrctory
    //"...Documents/UIImage.plist"
    static func filepathToDocumentDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
