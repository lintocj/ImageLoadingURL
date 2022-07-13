//
//  ImageCache.swift
//  ImageLoadingURL
//
//  Created by linto jacob on 13/07/22.
//

import Foundation
import UIKit

class ImageCacheFromURL {
    public static let `default` = ImageCacheFromURL()

    let imageCache = NSCache<NSString, UIImage>()

    func removeAllImageCache()  {
        imageCache.removeAllObjects()
    }

    func countLimit() -> Int  {
       return imageCache.countLimit
    }

    func totalCostLimit() -> Int  {
       return imageCache.totalCostLimit
    }

    func removeCacheIfCountLimitReaches(){
        if imageCache.totalCostLimit >= imageCache.countLimit - 10{
            removeAllImageCache()
        }
    }

    func removeSingleFileFromCache(key: NSString){
        imageCache.removeObject(forKey: key)

    }

    func loadImageUsingCache(imageFile : UIImageView, placeHolderImage: UIImage, withUrl urlString : String) {
        self.removeCacheIfCountLimitReaches()
        let url = URL(string: urlString)
        if url == nil {return}
        imageFile.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            imageFile.image = cachedImage
            return
        }
        var  activityIndicator: UIActivityIndicatorView!
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView.init(style: .medium)
        } else {
            activityIndicator = UIActivityIndicatorView.init(style: .gray)
        }

        imageFile.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = imageFile.center

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { [weak self] (data, response, error) in

            guard let self = self else { return }
            if let error = error {
                print(error)
                imageFile.image = placeHolderImage
                return
            }

            DispatchQueue.main.async { [self] in
                if let image = UIImage(data: data!) {
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    imageFile.image = image


                }else{
                    print("Image not found")
                    imageFile.image = placeHolderImage
                }
                activityIndicator.removeFromSuperview()
        }

        }).resume()
    }


}
