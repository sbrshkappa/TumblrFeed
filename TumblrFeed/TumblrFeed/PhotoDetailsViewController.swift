//
//  PhotoDetailsViewController.swift
//  TumblrFeed
//
//  Created by Sabareesh Kappagantu on 3/30/17.
//  Copyright © 2017 Sabareesh Kappagantu. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    var imageUrl: String?
    @IBOutlet weak var fullPhotoView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realUrl = URL(string: imageUrl!)
        fullPhotoView.setImageWith(realUrl!)

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
