//
//  AppInfo.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 16/03/23.
//

import Foundation

struct AppInfo {
    static var version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
    static var build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown"
}
