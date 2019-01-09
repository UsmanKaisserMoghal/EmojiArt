//
//  EmojiArtViewController.swift
//  EmojiArt
//
//  Created by MBP on 09/01/2019.
//  Copyright © 2019 MBP. All rights reserved.
//

import UIKit

class EmojiArtViewController: UIViewController, UIDropInteractionDelegate {
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var image: UIImage!
    
    private func fetch(url: URL) {
        spinner.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let urlConents = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = urlConents {
                    self?.image = UIImage(data:imageData)
                    self?.emojiArtView.backgroundImage = self?.image
                    self?.spinner.stopAnimating()
                }
            }
        }
    }

    @IBOutlet weak var dropZone: UIView!{
        didSet {
            dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
//    var imageFetcher: ImageFetcher!
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        
//        imageFetcher = ImageFetcher() { (url, image) in
//            DispatchQueue.main.async {
//                self.emojiArtView.backgroundImage = image
//            }
//        }
        
        
        session.loadObjects(ofClass: NSURL.self) { nsurls in
            if let url = nsurls.first as? URL {
                self.fetch(url: url)
            }
        }
        
        session.loadObjects(ofClass: UIImage.self) { images in
            if let image = images.first as? UIImage {
                self.image = image
            }
        }
    }
    
    @IBOutlet weak var emojiArtView: EmojiArtView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.transform = CGAffineTransform(scaleX: 3, y: 3)
    }
}
