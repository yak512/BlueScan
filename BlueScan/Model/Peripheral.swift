//
//  Peripheral.swift
//  BlueScan
//
//  Created by Yakoub on 29/01/2021.
//

import Foundation

struct Peripheral: Identifiable {
    let id: Int
    let name: String
    let rssi: Int
    var identifier: UUID
}
