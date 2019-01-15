//
//  PhotoCollectionViewCell.swift
//  PhotoJournal
//
//  Created by Yaz Burrell on 1/15/19.
//  Copyright © 2019 Yaz Burrell. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var editAlertButton: UIButton!
}
