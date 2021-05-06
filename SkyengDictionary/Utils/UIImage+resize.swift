//
//  UIImage+resize.swift
//  SkyengDictionary
//
//  Created by Екатерина Батеева on 06.05.2021.
//

import UIKit

extension UIImage {
    func resize(with multiplier: CGFloat) -> UIImage? {
        let size = self.size

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        newSize = CGSize(width: size.width * multiplier, height: size.height * multiplier)

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
