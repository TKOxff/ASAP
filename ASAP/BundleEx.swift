//
//  BundleEx.swift
//  ASAP
//
//  Created by TKOxff on 2021/03/19.
//

import Foundation


extension Bundle {
  var appName: String {
    return object(forInfoDictionaryKey: "CFBundleName") as? String ?? "?"
  }

  var appVersion: String {
    return String("\(shortVersion)-\(buildVersion)")
  }
  
  var shortVersion: String {
    return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "?"
  }
  
  var buildVersion: String {
    return object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "?"
  }
}
