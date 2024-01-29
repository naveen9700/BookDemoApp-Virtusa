//
//  ApiManager.swift
//  BooksDemoAPP
//
//  Created by Naveen on 27/01/24.
//

import Foundation

class APIManager {
     func fetchBookList(completion: @escaping (BooksResponse?) -> Void) {
         let url = Url.baseUrl + string.bookEvent
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            // Debugging: Print the raw JSON data
//               if let jsonString = String(data: data, encoding: .utf8) {
//                  // print("Raw JSON Data: \(jsonString)")
//               }
            do {
                let booksResponse = try JSONDecoder().decode(BooksResponse.self, from: data)
               // print(booksResponse)
                completion(booksResponse)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
