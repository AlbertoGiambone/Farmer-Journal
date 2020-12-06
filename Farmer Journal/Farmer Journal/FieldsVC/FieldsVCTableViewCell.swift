//
//  FieldsVCTableViewCell.swift
//  Farmer Journal
//
//  Created by Alberto Giambone on 22/11/20.
//

import UIKit

class FieldsVCTableViewCell: UITableViewCell {

    //MARK: Connection
    
    @IBOutlet weak var fieldCellName: UILabel!
    
    @IBOutlet weak var growing: UILabel!
    
    @IBOutlet weak var fertUnit: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
