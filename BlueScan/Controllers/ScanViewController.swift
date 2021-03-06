//
//  ViewController.swift
//  BlueScan
//
//  Created by Yakoub on 28/01/2021.
//

import UIKit
import CoreBluetooth


    // MARK: - CBCentralManagerDelegate
class ScanViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var isBluetoothOn: UILabel!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var myPeripherals = [Peripheral]()
    var isScanning = true
    var centralManager: CBCentralManager!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
            super.viewDidLoad()
            centralManager = CBCentralManager(delegate: self, queue: nil)
            scanButton.layer.cornerRadius = 7
        }
   
    // This function Check is the Bluetooth is enable in the device
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
    
    //This function discover peripheral and add it to the structur
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        var peripheralName: String!
        var isPeripheralAlreadyStored = false
        
        if let name = peripheral.name {
            peripheralName = name
        } else {
            peripheralName = "unknown"
        }
        // We verify is the peripheral is already stored in our structur
        for existingPeripheral in myPeripherals {
            if existingPeripheral.identifier == peripheral.identifier {
                isPeripheralAlreadyStored = true
            }
        }
        if (!isPeripheralAlreadyStored) {
            let newPeripheral = Peripheral(id: myPeripherals.count, name: peripheralName, rssi: RSSI.intValue, identifier: peripheral.identifier)
            print(newPeripheral)
            myPeripherals.append(newPeripheral)
            tableView.reloadData()
        }

    }
    
    // MARK: - action
    @IBAction func bleScan(_ sender: Any) {
        if centralManager.state == CBManagerState.poweredOn {
            if isScanning {
                print("scan on")
                centralManager.scanForPeripherals(withServices: nil, options: nil)
                isScanning = false
                configScanButton(color: .green, text: "Scanning", isOn: false)
            
            } else {
                print("scan off")
                centralManager.stopScan()
                configScanButton(color: .white, text: "Scan", isOn: true)
                isScanning = true
            }
        } else {
            alertBluetoothDisabled()
        }
    }
    
    // MARK: - Helpers
    private func configScanButton(color: UIColor, text: String, isOn: Bool) {
        scanButton.backgroundColor = color
        scanButton.setTitle(text, for: UIControl.State.normal)
        activityIndicator.isHidden = isOn
        scanButton.pulsate()
    }
    
    private func alertBluetoothDisabled() {
        let alertVc = UIAlertController(title: "INFO", message: "Please activate your bluetooth to start scanning", preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVc, animated: true, completion: nil)
    }
    
   

}

    // MARK: - UITableViewDelegate
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
                let detailVC = segue.destination as! PeripheralInfoViewController
                detailVC.myPeripheral = myPeripherals[indexPath.row]
            }
        }
    }
    
}
