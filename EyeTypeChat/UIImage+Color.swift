//
//  UIImage+Color.swift
//  EyeTypeChat
//
//  Created by Maria Ines Casadei on 1/30/15.
//  Copyright (c) 2015 SCV Soft. All rights reserved.
//

import Foundation

extension UIImage {
    
    //TODO: move to another class or make an extension
    func colorizeWith(color: UIColor) -> UIImage {
        
        UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        
        // set the blend mode to color burn, and the original image
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        let rect = CGRectMake(0, 0, self.size.width, self.size.height);
        CGContextDrawImage(context, rect, self.CGImage);
        
        // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
        CGContextClipToMask(context, rect, self.CGImage);
        CGContextAddRect(context, rect);
        CGContextDrawPath(context,kCGPathFill);
        
        // generate a new UIImage from the graphics context we drew onto
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //return the color-burned image
        return coloredImage;
    }
}
