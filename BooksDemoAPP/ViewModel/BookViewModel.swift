//
//  BooksListViewModel.swift
//  BooksDemoAPP
//
//  Created by Naveen on 27/01/24.
//

import Foundation

class BookViewModel {
    var booksResponse:BooksResponse?
    
    var apiManager:APIManager? = nil
    init(_ apiManager:APIManager) {
        self.apiManager = apiManager
    }

    func fetchBooks(completion: @escaping () -> Void) {
        self.apiManager?.fetchBookList { [weak self] response in
            guard let booksResponse = response else { return }
            self?.booksResponse = booksResponse
            print(booksResponse)
            completion()
        }
    }
    func numberOfBooks() -> Int {
        return self.booksResponse?.results.count ?? 0
    }
    func book(at index: Int) -> Result? {
        guard let results = self.booksResponse?.results, index < results.count else {
            // Handle out-of-bounds index or nil results array
            return nil
        }

        return results[index]
    }
}
