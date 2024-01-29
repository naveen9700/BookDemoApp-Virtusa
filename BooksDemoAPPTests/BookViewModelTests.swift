//
//  BookViewModelTests.swift
//  BooksDemoAPPTests
//
//  Created by Naveen on 28/01/24.
//

import XCTest

@testable import BooksDemoAPP

class BookViewModelTests: XCTestCase {

    // A mock API manager for testing
    class MockAPIManager: APIManager {
        var shouldReturnResponse: Bool = true
        var shouldReturnError: Bool = false

        override func fetchBookList(completion: @escaping (BooksResponse?) -> Void) {
            if shouldReturnError {
                completion(nil)
            } else {
                // Provide a mock response
                let author = Author(name: "Dickens, Charles")
                let formats = Formats(textHTML: "https://www.gutenberg.org/ebooks/46.html.images",
                                      imageJPEG: "https://www.gutenberg.org/cache/epub/46/pg46.cover.medium.jpg")
                
                let result = Result(id: 1, title: "Mock Book 1", authors: [author], formats: formats)
                
                let mockResponse = BooksResponse(count: 1, next: "", results: [result])
                completion(mockResponse)
               
            }
        }
    }

    // MARK: - Tests

    func testFetchBooksSuccess() {
        // Given
        let mockAPIManager = MockAPIManager()
        mockAPIManager.shouldReturnResponse = true
        let viewModel = BookViewModel(mockAPIManager)

        // When
        var fetchCompletionCalled = false
        viewModel.fetchBooks {
            fetchCompletionCalled = true
        }

        // Then
        XCTAssertTrue(fetchCompletionCalled)
        XCTAssertNotNil(viewModel.booksResponse)
        XCTAssertEqual(viewModel.numberOfBooks(), 1)
        XCTAssertEqual(viewModel.book(at: 0)?.title, "Mock Book 1")
       
    }

    func testFetchBooksFailure() {
        // Given
        let mockAPIManager = MockAPIManager()
        mockAPIManager.shouldReturnError = true
        let viewModel = BookViewModel(mockAPIManager)

        // When
        var fetchCompletionCalled = false
        viewModel.fetchBooks {
            fetchCompletionCalled = true
        }

        // Then
        XCTAssertFalse(fetchCompletionCalled)
        XCTAssertNil(viewModel.booksResponse)
        XCTAssertEqual(viewModel.numberOfBooks(), 0)
        XCTAssertNil(viewModel.book(at: 0))
    }
}
