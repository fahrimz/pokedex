//
//  DeviceHelper.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 17/03/23.
//

import SwiftUI

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    static var isLandscape: Bool {
        UIScreen.main.bounds.height < UIScreen.main.bounds.width
    }
}
