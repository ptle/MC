//
//  DetailViewController.swift
//  MC
//
//  Created by Peter Le on 1/6/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var information: UIView!
    var image: UIImage!
    var movie: NSDictionary!
    var time = 0
    @IBOutlet weak var movietitle: UILabel!
    @IBOutlet weak var moviedate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var plot: UITextView!
    
    @IBOutlet weak var calender: UIImageView!
    @IBOutlet weak var star: UIImageView!
    @IBOutlet weak var clock: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        image!.draw(in: self.view.bounds)
        
        let image1: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image1)

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.5
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.addSubview(information)
        
        if let image = UIImage(named:"calender") {
            calender.image = image
        }
        if let image = UIImage(named:"star") {
            star.image = image
        }
        if let image = UIImage(named:"clock") {
            clock.image = image
        }
        plot.isEditable = false
        
        information?.backgroundColor = UIColor(white: 0, alpha: 0.3)
        information.layer.cornerRadius = 5;
        information.layer.masksToBounds = true;
        
        movietitle.text = movie["title"] as? String
        moviedate.text = movie["release_date"] as? String
        let a = movie["vote_average"] as? Double
        let b:String = String(format:"%.1f", a!)
        rating.text = b
        plot.text = movie["overview"] as? String
        let c = time
        let hours = (c/60)
        let minutes = (c-(hours*60))
        let d = "\(hours)h \(minutes)m"
        duration.text = d
        
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
