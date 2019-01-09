//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by MBP on 09/01/2019.
//  Copyright © 2019 MBP. All rights reserved.
//

import UIKit

class EmojiArtView: UIView {

    var backgroundImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }

}
