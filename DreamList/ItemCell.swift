//
//  ItemCell.swift
//  DreamList
//
//  Created by Dmytro Aprelenko on 24.01.17.
//  Copyright © 2017 Dmytro Aprelenko. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet weak var wishImage: UIImageView!
    @IBOutlet weak var wishTitle: UILabel!
    @IBOutlet weak var wishMeans: UILabel!
    @IBOutlet weak var wishDetails: UILabel!
    
    func configureCell(item: Item) {
        wishTitle.text = item.title
        wishMeans.text = ("\(item.price)")
        wishDetails.text = item.details
        //wishImage.image = UIImage.
        
    }
}
