//
//  MovieTableViewCell.swift
//  MovieAPICall2
//
//  Created by Michelle M on 18/11/2018.
//  Copyright © 2018 batgirl. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    var moviesFormatted: MoviesFormatted!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(moviesFormatted: MoviesFormatted) {
        self.moviesFormatted = moviesFormatted
        
        self.title.text = self.moviesFormatted.title
        self.year.text = self.moviesFormatted.year
        
        let url = URL(string: self.moviesFormatted.poster)
        let data = try? Data(contentsOf: url!)
        let img = UIImage(data: data!)

        // Trying to resize image proportionately
        let newImg = self.resizeImage(img!, newHeight: 188.0)
        
        self.posterImg.image = newImg
        
//        var tempImg = UIColor.white.image(CGSize(width:300, height: 161.0))
//        let tempImgView = self.posterImg
//        tempImgView?.downloaded(from: self.moviesFormatted.poster)
//        let newImg = self.resizeImage(tempImgView, newHeight: 161.0)
//
//        self.posterImg.image = newImg
    }
    
    // Func to resize image proportionately
    func resizeImage(_ image: UIImage, newHeight: CGFloat) -> UIImage {
        //print("debug before: width: \(image.size.width) height: \(image.size.height)")
        
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let imgData = newImage!.jpegData(compressionQuality: 0.5)! as Data
        UIGraphicsEndImageContext()
        
        //print("debug after: width: \(newImage?.size.width) height: \(newImage?.size.height)")
        
        return UIImage(data:imgData)!
    }
}

//extension UIImageView {
//    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() {
//                self.image = image
//            }
//            }.resume()
//    }
//    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url, contentMode: mode)
//    }
//}

//extension UIColor {
//    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
//        return UIGraphicsImageRenderer(size: size).image { rendererContext in
//            self.setFill()
//            rendererContext.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
//        }
//    }
//}
