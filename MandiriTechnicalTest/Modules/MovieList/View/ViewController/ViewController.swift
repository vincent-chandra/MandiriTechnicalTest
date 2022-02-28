//
//  ViewController.swift
//  MandiriTechnicalTest
//
//  Created by Vincent on 24/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var listGenreTableView: UITableView!
    
    var arrayGenre: Genres?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listGenreTableView.delegate = self
        listGenreTableView.dataSource = self
        
        listGenreTableView.register(UINib(nibName: "GenreTableViewCell", bundle: nil), forCellReuseIdentifier: "GenreTableViewCell")
        
        ListMoviesInteractor.fetchAPIGenre(url: Constants.URLGenre) { data in
            DispatchQueue.main.async {
                self.arrayGenre = data
                self.listGenreTableView.reloadData()
            }
        }
        
        self.title = "Movie Genres"
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayGenre?.genres?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listGenreTableView.dequeueReusableCell(withIdentifier: "GenreTableViewCell", for: indexPath) as! GenreTableViewCell
        cell.genresLabel.text = arrayGenre?.genres?[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "MovieViewController", bundle: nil).instantiateViewController(withIdentifier: "MovieViewController") as? MovieViewController
        vc?.genre = arrayGenre?.genres?[indexPath.row].id ?? 35
        vc?.genreName = arrayGenre?.genres?[indexPath.row].name ?? ""
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}

