//
//  SchoolGalleryTableViewCell.swift
//  Artco
//
//  Created by Mitchell Budge on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class SchoolGalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
