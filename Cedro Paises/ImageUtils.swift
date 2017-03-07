//
//  ImageUtils.swift
//  Cedro Paises
//
//  Created by Matheus Alves on 02/03/17.
//  Copyright © 2017 Matheus Alves. All rights reserved.
//

import Foundation
import UIKit

class ImageUtils {
    
    static func getImageByUrl(url: String) -> String {
        do {
            let url:NSURL = NSURL(string : url)!
            let imageData:NSData = try NSData.init(contentsOf: url as URL)!
            let strBase64:String = try imageData.base64EncodedString(options: .lineLength64Characters)
            return strBase64
        } catch {
            return ""
        }
    }
    
    static func getImageByBase64(strBase64: String) -> UIImage{
        let dataDecoded:NSData = NSData(base64Encoded: strBase64, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: dataDecoded as Data)!
    }
    
}
