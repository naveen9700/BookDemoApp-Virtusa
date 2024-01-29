//
//  BooksCell.swift
//  BooksDemoAPP
//
//  Created by Naveen on 27/01/24.
//

import UIKit

class BooksCell: UITableViewCell {

    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var BGView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        BGView.layer.cornerRadius = 10
        BGView.layer.masksToBounds = false
                // Add shadow
        BGView.layer.shadowColor = UIColor.black.cgColor
        BGView.layer.shadowOpacity = 0.3
        BGView.layer.shadowOffset = CGSize(width: 0, height: 1)
        BGView.layer.shadowRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
