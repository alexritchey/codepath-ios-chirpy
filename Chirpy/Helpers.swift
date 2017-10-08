//
//  Helpers.swift
//  Chirpy
//
//  Created by Alex Ritchey on 10/8/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit

class Helpers: NSObject {

    static func makeImageCircular(with image: UIImageView) -> UIImageView {
        image.layer.cornerRadius = image.frame.size.height / 2
        image.clipsToBounds = true
        return image
    }
    
}
