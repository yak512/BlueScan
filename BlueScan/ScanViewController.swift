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
    var identifier: UUID
}

class ScanViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    @IBOutlet weak var isBluetoothOn: UILabel!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var myPeripherals = [Peripheral]()
    var isScan = true
    
    var centralManager: CBCentralManager!
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            print("BLE is on")
            isBluetoothOn.textColor = .green
            isBluetoothOn.text = "Bluetooth is on"
        } else {
            print("BLE is off")
            isBluetoothOn.textColor = .red
            isBluetoothOn.text = "Bluetooth is off"
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        var peripheralName: String!
        var isPeripheralExist = false
        
        if let name = peripheral.name {
            peripheralName = name
        } else {
            peripheralName = "unknown"
        }
        for existingPeripheral in myPeripherals {
            if existingPeripheral.identifier == peripheral.identifier {
                isPeripheralExist = true
            }
        }
        if (!isPeripheralExist) {
            let newPeripheral = Peripheral(id: myPeripherals.count, name: peripheralName, rssi: RSSI.intValue, identifier: peripheral.identifier)
            print(newPeripheral)
            myPeripherals.append(newPeripheral)
            tableView.reloadData()
        }

    }
    
    
    @IBAction func bleScan(_ sender: Any) {
        if isScan {
            print("scan on")
            centralManager.scanForPeripherals(withServices: nil, options: nil)
            isScan = false
            scanButton.backgroundColor = .green
           // scanButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            activityIndicator.isHidden = false
            scanButton.setTitle("Scanning...", for: UIControl.State.normal)
            scanButton.pulsate()
            
        } else {
            print("scan off")
            centralManager.stopScan()
            isScan = true
            scanButton.backgroundColor = .white
            activityIndicator.isHidden = true
          //  scanButton.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
            scanButton.setTitle("Scan", for: UIControl.State.normal)
            scanButton.pulsate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        scanButton.layer.cornerRadius = 7
    }

}

extension ScanViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myPeripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as? DeviceTableViewCell else {
            return UITableViewCell()
        }
        
        let myDevice = myPeripherals[indexPath.row]
        
        cell.configure(name: myDevice.name, id: myDevice.id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      performSegue(withIdentifier: "segueToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            if segue.identifier == "segueToDetail" {
                let detailVC = segue.destination as! DeviceViewController
                detailVC.myPeripheral = myPeripherals[indexPath.row]
            }
        }
    }
    
}

extension UIButton {
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.9
        pulse.toValue = 1.15
        pulse.autoreverses = true
        pulse.repeatCount = 0.5
        pulse.initialVelocity = 0.7
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}
