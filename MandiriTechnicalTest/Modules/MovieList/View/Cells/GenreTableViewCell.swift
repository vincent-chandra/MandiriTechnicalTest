//
//  GenreTableViewCell.swift
//  MandiriTechnicalTest
//
//  Created by Vincent on 25/02/22.
//

import UIKit

class GenreTableViewCell: UITableViewCell {

    @IBOutlet weak var genresView: UIView!
    @IBOutlet weak var genresLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
