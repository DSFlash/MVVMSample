//
//  PhotoDetailViewController.swift
//  MVVMPlayground
//
//  Created by Neo on 03/10/2017.
//  Copyright © 2017 ST.Huang. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoDetailViewController: UIViewController {

    var imageUrl: String?
    
    @IBOutlet weak var imageView: UIImageView!
    
    lazy var detailViewModel: PhotoListViewModel = {
        return PhotoListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageUrl = imageUrl {
            imageView.sd_setImage(with: URL(string: imageUrl)) { (image, error, type, url) in
            
            }
        }
        //add a bar button item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editPhoto))
        
        self.attatchMethods()
        
    }
    
    @objc func editPhoto() {
        self.detailViewModel.editPhotoButtonPressed()
    }
    
    //attach methods for navigation on value change
    func attatchMethods() {
        
        detailViewModel.editPhoto = { [weak self] () in
            DispatchQueue.main.async {
                self?.performSegue(withIdentifier: "picVC", sender: self)
            }
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
