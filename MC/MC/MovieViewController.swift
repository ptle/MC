//
//  MovieViewController.swift
//  MC
//
//  Created by Peter Le on 1/5/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD


class MovieViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    var searchController : UISearchController!
    var movies: [NSDictionary]?
    var filteredData: [NSDictionary]?
    var refreshControl: UIRefreshControl!
    var duration: [NSDictionary: Int] = [:]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var networkerror: UIView!
    @IBOutlet weak var networkimage: UIImageView!
    
    
    func loadDataFromNetwork() {
        
        // ... Create the NSURLRequest (myRequest) ...
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Configure session so that completion handler is executed on main UI thread
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        // Display HUD right before the request is made
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (data, response, error) in
            // Hide HUD once the network request comes back (must be done on main UI thread)
            MBProgressHUD.hide(for: self.view, animated: true)
            // ... Remainder of response handling code ...
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    self.movies = (dataDictionary["results"] as! [NSDictionary])
                    self.filteredData = self.movies
                    self.collectionView.reloadData()
                    self.networkerror.isHidden = true
                }
                for movie in self.movies!
                {
                    self.getDuration(movie1: movie)
                }
            }
            if (error != nil) {
                self.networkerror.isHidden = false
            }
        });
        task.resume()
    }
    
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(refreshControl: UIRefreshControl) {
        // ... Create the NSURLRequest (myRequest) ...
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Configure session so that completion handler is executed on main UI thread
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (data, response, error) in
                                                                        
            // ... Use the new data to update the data source ...
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    self.movies = (dataDictionary["results"] as! [NSDictionary])
                    self.filteredData = self.movies
                    self.collectionView.reloadData()
                    self.networkerror.isHidden = true
                }
            }
            if (error != nil) {
                self.networkerror.isHidden = false
            }
            // Tell the refreshControl to stop spinning
            refreshControl.endRefreshing()
        });
        task.resume()
        
        refreshControl.endRefreshing()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        
        
        
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
        
        refreshControl = UIRefreshControl()
        var attr = [NSForegroundColorAttributeName:UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attr)
        refreshControl.addTarget(self, action: #selector(MovieViewController.refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        collectionView.insertSubview(refreshControl, at: 0)
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        if let image = UIImage(named:"error") {
            networkimage.image = image
        }
        networkerror.isHidden = true
        
        
        loadDataFromNetwork()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let filteredData = filteredData
        {
            return filteredData.count
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let movie = filteredData![indexPath.item]
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        let posterPath = movie["poster_path"] as! String
        let smallImageRequest = NSURLRequest(url: NSURL(string: baseUrl + posterPath)! as URL)
        let largeImageRequest = NSURLRequest(url: NSURL(string: baseUrl + posterPath)! as URL)
        cell.poster.setImageWith(
            smallImageRequest as URLRequest,
            placeholderImage: nil,
            success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                
                // smallImageResponse will be nil if the smallImage is already available
                // in cache (might want to do something smarter in that case).
                cell.poster.alpha = 0.0
                cell.poster.image = smallImage;
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    
                    cell.poster.alpha = 1.0
                    
                }, completion: { (sucess) -> Void in
                    
                    // The AFNetworking ImageView Category only allows one request to be sent at a time
                    // per ImageView. This code must be in the completion block.
                    cell.poster.setImageWith(
                        largeImageRequest as URLRequest,
                        placeholderImage: smallImage,
                        success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                            
                            cell.poster.image = largeImage;
                            
                    },
                        failure: { (request, response, error) -> Void in
                            // do something for the failure condition of the large image request
                            // possibly setting the ImageView's image to a default image
                    })
                })
        },
            failure: { (request, response, error) -> Void in
                // do something for the failure condition
                // possibly try to get the large image
        })
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! MovieCollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)
        let movie = filteredData![indexPath!.item]
        
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
        getDuration(movie1: movie)
        detailViewController.time = duration[movie]!
        
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        let posterPath = movie["poster_path"] as! String
        let imageUrl = NSURL(string: baseUrl + posterPath)
        let data = NSData(contentsOf: imageUrl as! URL)
        detailViewController.image = UIImage(data: data as! Data)
        
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
            if let searchText = searchController.searchBar.text {
                if searchText.isEmpty {
                    filteredData = movies
                }
                else
                {
                    filteredData = movies!.filter({(dataItem: NSDictionary) -> Bool in
                        let title = dataItem["title"] as! String
                        if title.range(of: searchText, options: .caseInsensitive) != nil {
                            return true
                        }
                        else {
                            return false
                        }
                    })
                }
                collectionView.reloadData()
            }

    }
    
    func getDuration(movie1: NSDictionary){
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let movie_id = movie1["id"] as? Int
        let id = "\(movie_id!)"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Configure session so that completion handler is executed on main UI thread
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        // Display HUD right before the request is made
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (data, response, error) in
            // Hide HUD once the network request comes back (must be done on main UI thread)
            // ... Remainder of response handling code ...
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    self.duration[movie1] = dataDictionary["runtime"] as! Int
                }
            }
        });
        task.resume()
        
    }
    
    @IBAction func onTap(_ sender: Any) {
        loadDataFromNetwork()
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
