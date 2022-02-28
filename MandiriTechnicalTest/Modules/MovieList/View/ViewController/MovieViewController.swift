//
//  MovieViewController.swift
//  MandiriTechnicalTest
//
//  Created by Vincent on 25/02/22.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var listMovieTableView: UITableView!
    
    var moviesArray = Movies()
    var currentPage = 1
    var genre = 35
    var genreName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listMovieTableView.delegate = self
        listMovieTableView.dataSource = self
        
        listMovieTableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
        
        ListMoviesInteractor.fetchAPIMovieList(page: currentPage, genre: genre) { data in
            DispatchQueue.main.async {
                self.moviesArray = data
                self.listMovieTableView.reloadData()
            }
        }
        
        self.title = genreName
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listMovieTableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as! MovieListTableViewCell
        cell.movieImageView.loadImage(fromURL: "https://image.tmdb.org/t/p/original\(moviesArray.results?[indexPath.row].poster_path ?? "")")
        cell.movieNameLabel.text = moviesArray.results?[indexPath.row].title
        cell.movieOvierviewLabel.text = moviesArray.results?[indexPath.row].overview
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "MovieDetailsViewController", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController
        vc?.id = moviesArray.results?[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == moviesArray.results!.count - 1){
            currentPage += 1
            ListMoviesInteractor.fetchAPIMovieList(page: currentPage, genre: genre) { data in
                DispatchQueue.main.async {
                    self.moviesArray.results?.append(contentsOf: data.results ?? [])
                    self.listMovieTableView.reloadData()
                }
            }
        }
    }
}

extension UIImageView {
    func loadImage(fromURL urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        let activityView = UIActivityIndicatorView(style: .large)
        self.addSubview(activityView)
        activityView.frame = self.bounds
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityView.startAnimating()

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                activityView.stopAnimating()
                activityView.removeFromSuperview()
            }

            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
