//
//  DeviceViewController.swift
//  BlueScan
//
//  Created by Yakoub on 29/01/2021.
//

import UIKit

class DeviceViewController: UIViewController {

    var myPeripheral: Peripheral!
    
    @IBOutlet weak var deviceNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceNameLabel.text = myPeripheral.name
    }
    
    
    

   

}
