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
    
    @IBOutlet weak var deviceNumberLabel: UILabel!
    
    @IBOutlet weak var deviceIdentifierUUIDLabel: UILabel!
    
    @IBOutlet weak var deviceRSSILabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDeviceInfo()
    }
    
    private func configureDeviceInfo() {
        deviceNameLabel.text = myPeripheral.name
        print(myPeripheral.identifier)
        deviceIdentifierUUIDLabel.text = "\(myPeripheral.identifier)"
        deviceNumberLabel.text = "\(myPeripheral.id+1)"
        deviceRSSILabel.text = "\(myPeripheral.rssi)"
        
    }
    
    

   

}
