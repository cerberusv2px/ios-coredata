//
//  TableViewCell.swift
//  CoreDataSample
//
//  Created by Sujin Shrestha on 12/6/18.
//  Copyright © 2018 Sujin Shrestha. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //Outlets
    
    @IBOutlet weak var taskLbl: UILabel!
    
    // Variables
    
    
    // Constants
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
