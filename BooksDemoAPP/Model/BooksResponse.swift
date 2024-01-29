//
//  BooksResponse.swift
//  BooksDemoAPP
//
//  Created by Naveen on 27/01/24.
//

import Foundation

// MARK: - Welcome
struct BooksResponse: Codable {
    let count: Int
    let next: String
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let title: String
    let authors :[Author]
    let formats: Formats
  
}

// MARK: - Author
struct Author: Codable {
    let name: String
   
}

// MARK: - Formats
struct Formats: Codable {
    let textHTML : String
    let imageJPEG: String

    enum CodingKeys: String, CodingKey {
        case textHTML = "text/html"
        case imageJPEG = "image/jpeg"
    }
}
