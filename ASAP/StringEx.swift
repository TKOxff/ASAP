//
//  StringEx.swift
//  AppSpawnKey
//
//  Created by TKOxff on 2021/03/14.
//

import Foundation


extension String {
  
  // App Name.app -> App Name
  var splitedAppName : String {
    let substrings = self.split(separator: ".")
    return String(substrings.first ?? "")
  }
}
