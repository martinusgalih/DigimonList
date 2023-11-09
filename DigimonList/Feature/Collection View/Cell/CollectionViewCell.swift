//
//  CollectionViewCell.swift
//  DigimonList
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var illustrationImage: UIImageView!
    
    func setItem(item: ReponseDigimonList) {
        nameLabel.text = item.name
        let url = URL(string: item.img)
        illustrationImage.kf.setImage(with: url)
        levelLabel.text = item.level
    }
}
