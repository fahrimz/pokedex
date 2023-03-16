//
//  AppInfo.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 16/03/23.
//

import Foundation

struct AppInfo {
    static var appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
}
