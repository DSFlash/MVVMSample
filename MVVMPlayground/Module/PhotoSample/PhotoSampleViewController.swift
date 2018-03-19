//
//  PhotoSampleViewController.swift
//  MVVMPlayground
//
//  Created by InfyMac on 16/03/18.
//  Copyright © 2018 ST.Huang. All rights reserved.
//

import UIKit

class PhotoSampleViewController: UIViewController {

    
    var sampleViewModel: PhotoListViewModel = {
        return PhotoListViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Controller - 1"
        // Do any additional setup after loading the view.
        
        self.showAlert(message: "Sample Controller Screen")
        
        
    }
    
    func showAlert(message: String) {
        let alertCon = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertCon.addAction(alertAction)
        
        present(alertCon, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
