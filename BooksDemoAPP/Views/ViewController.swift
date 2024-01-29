//
//  ViewController.swift
//  BooksDemoAPP
//
//  Created by Naveen on 27/01/24.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var booksTableView: UITableView!
    
    private var viewModel:BookViewModel?
    private var apimanager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          self.navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        fetchBooks()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        self.navigationItem.title = "Books"
    }
   
    
    func fetchBooks(){
        ActivityIndicatorManager.shared.showActivityIndicator(in: self.view)
        viewModel = BookViewModel(apimanager)
        viewModel?.fetchBooks {
            DispatchQueue.main.async {
                self.booksTableView.reloadData()
                ActivityIndicatorManager.shared.hideActivityIndicator()
            }
        }
    }
    func setupTableView() {
        booksTableView.dataSource = self
        booksTableView.delegate = self
        booksTableView.register(UINib(nibName: "BooksCell", bundle: nil), forCellReuseIdentifier: "BooksCell")
    }
  

}


extension ViewController:UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfBooks() ?? 0
       }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BooksCell", for: indexPath) as! BooksCell
        let book = viewModel?.book(at: indexPath.row)
        cell.bookTitle.text = "Title: " + (book?.title ?? "N/A")
        cell.authorName.text = "Author: " + (book?.authors.first?.name ?? "N/A")
        if let url = URL(string: (book?.formats.imageJPEG)!) {
            cell.bookImage.loadImage(from: url)
               }
            return cell
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = viewModel?.book(at: indexPath.row)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookDetailVC") as! BookDetailVC
        vc.bookUrl = (book?.formats.textHTML)!
        vc.navigationItem.title = book?.title
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
}

