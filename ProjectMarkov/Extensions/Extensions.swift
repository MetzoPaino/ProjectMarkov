//
//  Extensions.swift
//  ProjectMarkov
//
//  Created by William Robinson on 08/11/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import UIKit

// MARK: - UIImage

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}