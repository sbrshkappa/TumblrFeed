//
//  PhotoViewController.swift
//  TumblrFeed
//
//  Created by Sabareesh Kappagantu on 3/30/17.
//  Copyright © 2017 Sabareesh Kappagantu. All rights reserved.
//

import UIKit
import AFNetworking

class PhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tumblrTableView: UITableView!
    var posts: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tumblrTableView.delegate = self
        tumblrTableView.dataSource = self
        tumblrTableView.rowHeight = 240

        //defining the url to use for getting Tumblr Data
        let tumblrURL = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")
        let request = URLRequest(url: tumblrURL!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task: URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        print("responseDictionary: \(responseDictionary)")
                        
                        // Recall there are two fields in the response dictionary, 'meta' and 'response'.
                        // This is how we get the 'response' field
                        let responseFieldDictionary = responseDictionary["response"] as! NSDictionary
                        
                        // This is where you will store the returned array of posts in your posts property
                        self.posts = responseFieldDictionary["posts"] as! [NSDictionary]
                        self.tumblrTableView.reloadData()
                    }
                }
        });
        task.resume()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Implemnting TableViewController specific methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tumblrTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        if (posts.count != 0){
            let post = posts[indexPath.row]
            if let photos = post.value(forKey: "photos") as? [NSDictionary] {
                
                let imageUrlString = photos[0].value(forKeyPath: "original_size.url") as? String
                if let imageUrl = URL(string: imageUrlString!) {
                    cell.photoView.setImageWith(imageUrl)
                } else {
                    //Error the imageUrl is Nil
                }
            } else {
                //Error the photos array is Nil
            }
            return cell
            
        } else {
            return cell
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoDetailsViewController
        let indexPath = tumblrTableView.indexPath(for: sender as! UITableViewCell)!
        
        let image = self.posts[indexPath.row]["photos"] as! [NSDictionary]
        vc.imageUrl = image[0].value(forKeyPath: "original_size.url") as? String
        
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
