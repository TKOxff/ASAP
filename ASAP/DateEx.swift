//
//  DateEx.swift
//  App SpawnKey
//
//  Created by TKOxff on 2021/03/15.
//

import Foundation


public extension Date {
  
  var currentTimeMS: Int64 {
    return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
  }

  var currentTime: Int64 {
    return Int64((self.timeIntervalSince1970 * 1000000.0).rounded())
  }

  func diffDay(to toDate: Date) -> Int {
    let d1 = Calendar.current.startOfDay(for: self)
    let d2 = Calendar.current.startOfDay(for: toDate)
    let diff = Calendar.current.dateComponents([.day], from: d1, to: d2)
    return diff.day ?? 0
  }
}
