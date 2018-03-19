//
//  PicViewController.swift
//  MVVMPlayground
//
//  Created by InfyMac on 19/03/18.
//  Copyright © 2018 ST.Huang. All rights reserved.
//

import UIKit

class PicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let alertCon = UIAlertController(title: "Pic Controller Screen", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertCon.addAction(alertAction)
        
        present(alertCon, animated: true, completion: nil)
        
        // Do any additional setup after loading the view.
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
