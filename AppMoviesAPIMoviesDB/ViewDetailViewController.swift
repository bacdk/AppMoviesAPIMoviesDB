//
//  ViewDetailViewController.swift
//  AppMoviesAPIMoviesDB
//
//  Created by Cntt20 on 5/17/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class ViewDetailViewController: UIViewController {
    //
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var releaseDayMovie: UILabel!
    @IBOutlet weak var voteMovie: UILabel!
    @IBOutlet weak var budgetMovie: UILabel!
    @IBOutlet weak var revenueMovie: UILabel!
    @IBOutlet weak var overViewMovie: UILabel!
    @IBOutlet weak var scrollViewMovie: UIScrollView!
    //
    var id: Int?
    var image: UIImage?


    override func viewDidLoad() {
        super.viewDidLoad()
        //
        getMovieDetail()
        title = "Movie Detail"
        imageMovie.image = image

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    
    // Hàm lấy thông tin chi tiết phim từ trang The MovieDB
    func getMovieDetail() {
        if let movieId = id {
            let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(API)&language=en-US")
            var detail = [String:Any]()
            let request = NSMutableURLRequest(url: url! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5)
            request.httpMethod = "GET"
            _ = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (Data, URLResponse, Error) in
                if (Error != nil) {
                    print(Error!)
                } else {
                    do {
                        detail = try JSONSerialization.jsonObject(with: Data!, options: .allowFragments) as! [String:Any]
                        DispatchQueue.main.async {
                            self.titleMovie.text = detail["title"]! as? String
                            if let day = detail["release_date"] {
                                self.releaseDayMovie.text = "Release Date: \(day)"
                            }
                            if let vote = detail["vote_average"] {
                                self.voteMovie.text = "⭐️ \(vote)"
                            }
                            if let budget = detail["budget"] {
                                self.budgetMovie.text = "Budget: \(budget)$"
                            }
                            if let revenue = detail["revenue"] {
                                self.revenueMovie.text = "Revenue: \(revenue)$"
                            }
                            if let overview = detail["overview"] {
                                self.overViewMovie.text = "Overview: \(overview)"
                            }
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }).resume()
        }
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
