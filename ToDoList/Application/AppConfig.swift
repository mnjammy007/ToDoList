//
//  AppConfig.swift
//  ToDoList
//
//  Created by Apple on 23/12/25.
//

import Foundation

enum AppConfig {

    static var appsFlyerDevKeyTest: String {
        guard let key = Bundle.main.object(
            forInfoDictionaryKey: "appsFlyerDevKeyTest"
        ) as? String, !key.isEmpty else {
            fatalError("appsFlyerDevKeyTest missing in Info.plist")
        }
        return key
    }
    static var appsFlyerDevKeyProd: String {
        guard let key = Bundle.main.object(
            forInfoDictionaryKey: "appsFlyerDevKeyProd"
        ) as? String, !key.isEmpty else {
            fatalError("appsFlyerDevKeyProd missing in Info.plist")
        }
        return key
    }

    static var appleAppID: String {
        guard let id = Bundle.main.object(
            forInfoDictionaryKey: "appleAppID"
        ) as? String, !id.isEmpty else {
            fatalError("appleAppID missing in Info.plist")
        }
        return id
    }
}
