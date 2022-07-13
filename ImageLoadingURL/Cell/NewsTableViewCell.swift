//
//  NewsTableViewCell.swift
//  ImageLoadingURL
//
//  Created by linto jacob on 13/07/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadImage(url: String) {
        ImageCacheFromURL.default.loadImageUsingCache(imageFile: newsImage, placeHolderImage: UIImage(named: "placeholder") ?? UIImage(), withUrl: url)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
