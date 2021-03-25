//
//  Constants.swift
//  AppSpawnKey
//
//  Created by TKOxff on 2021/03/14.
//

import Foundation

enum LaunchOption: String, CaseIterable, Identifiable {
  case OpenExistOne
  case NewInstance
  
  var id: String { self.rawValue }
}
