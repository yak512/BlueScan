//
//  DeviceViewController.swift
//  BlueScan
//
//  Created by Yakoub on 29/01/2021.
//

import UIKit

class DeviceViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var deviceNumberLabel: UILabel!
    @IBOutlet weak var deviceIdentifierUUIDLabel: UILabel!
    @IBOutlet weak var deviceRSSILabel: UILabel!
    
    // MARK: - Properties
    var myPeripheral: Peripheral!
    
    // MARK: - Lifecycle
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
