//
//  DeviceTableViewCell.swift
//  BlueScan
//
//  Created by Yakoub on 29/01/2021.
//

import UIKit

class DeviceTableViewCell : UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var deviceNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGraphic()
    }
    
    func configure(name: String, id: Int) {
        deviceNameLabel.text = "Device N°\(id+1):    " + name 
    }
    
    fileprivate func addGraphic() {
        cellView.layer.cornerRadius = 10
    }
}
