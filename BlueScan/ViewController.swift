//
//  ViewController.swift
//  BlueScan
//
//  Created by Yakoub on 28/01/2021.
//

import UIKit
import CoreBluetooth

struct Peripheral: Identifiable {
    let id: Int
    let name: String
    let rssi: Int
}

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var peripherals = [Peripheral]()
    
    var centralManager: CBCentralManager!
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            print("BLE is on")
            central.scanForPeripherals(withServices: nil, options: nil)
        } else {
            print("BLE is off")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if let name = peripheral.name {
            print(name)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }


}

