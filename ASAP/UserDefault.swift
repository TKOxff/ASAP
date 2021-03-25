//
//  UserDefault.swift
//  TKOxLib
//
//  Created by TKOxff on 2020/03/11.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
  let key: String
  let defaultValue: T
  
  init(_ key: String, defaultValue: T) {
    self.key = key
    self.defaultValue = defaultValue
  }
  
  var wrappedValue: T {
    get {
      let val = UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
      print("get UserDefault<\(key)> value:\(val)")
      return val
    }
    set {
      print("set UserDefault<\(key)> value:\(newValue)")
      UserDefaults.standard.set(newValue, forKey: key)
    }
  }
}

@propertyWrapper
struct UserDefaultIntArray {
  let key: String
  let defaultValue: Int
  let count: Int

  init(_ key: String, defaultValue: Int, count: Int) {
    self.key = key
    self.defaultValue = defaultValue
    self.count = count
  }

  var wrappedValue: [Int] {
    get {
      let ret = UserDefaults.standard.array(forKey: key) as? [Int]
        ?? [Int](repeating: defaultValue, count: self.count)
      return ret
    }
    set {
      UserDefaults.standard.set(newValue, forKey: key)
    }
  }
}
