//
//  AppItem.swift
//  MacShortcut
//
//  Created by TKOxff on 2021/03/03.
//

import Foundation
import SwiftUI
import MASShortcut


class AppItem: Codable,
               Hashable, Equatable, // for List selection
               ObservableObject,
               CustomDebugStringConvertible
{
  let id = UUID()
  
  // stored variables
  let name: String
  let bundleURL: URL?
  @Published var shortcut: MASShortcut?
  @Published var enable: Bool
  @Published var launchOption: LaunchOption
  
  enum CodingKeys: String, CodingKey {
    case name, bundleURL, shortcut, enable, launchOpt
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: AppItem, rhs: AppItem) -> Bool {
    return lhs.hashValue == rhs.hashValue
  }
  
  // load saved apps from savefile
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.name = try container.decode(String.self, forKey: .name)
    self.bundleURL = try container.decode(URL.self, forKey: .bundleURL)
    self.enable = try container.decode(Bool.self, forKey: .enable)
    let launchOption = try container.decode(String.self, forKey: .launchOpt)
    self.launchOption = LaunchOption(rawValue: launchOption)!
    
    let shortcutData = try container.decode(Data.self, forKey: .shortcut)
    self.shortcut = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(shortcutData) as? MASShortcut ?? nil
  }
  
  // make a save data of apps
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(name, forKey: .name)
    try container.encode(bundleURL, forKey: .bundleURL)
    try container.encode(enable, forKey: .enable)
    try container.encode(launchOption.rawValue, forKey: .launchOpt)
    
    let shortcutData = try NSKeyedArchiver.archivedData(withRootObject: self.shortcut ?? NSNull(), requiringSecureCoding: false)
    try container.encode(shortcutData, forKey: .shortcut)
  }

  // Very New
  init?(metaData: NSMetadataItem) {

    guard let path = metaData.value(forAttribute: kMDItemPath as String) as? String,
          let appBundle = Bundle(path: path) else {
      return nil
    }
    
    let displayName = (metaData.value(forAttribute: kMDItemDisplayName as String) as? String)!
    self.name = displayName.splitedAppName
    self.bundleURL = appBundle.bundleURL
    self.shortcut = nil
    self.enable = true
    self.launchOption = LaunchOption.OpenExistOne
  }
  
  convenience init?(metaData: NSMetadataItem, shortcut: MASShortcut) {
    self.init(metaData: metaData)
    self.shortcut = shortcut
  }
  
  var icon: NSImage {

    guard let bundle = Bundle(url: bundleURL!) else {
      print("invalid bundleURL:" + bundleURL!.path)
      return NSImage(named:"egg+question")!
    }
    
    var iconImage: NSImage?
    
    if let iconFileName = (bundle.infoDictionary?["CFBundleIconFile"]) as? String,
       let iconFilePath = bundle.pathForImageResource(iconFileName)
    {
      iconImage = NSImage(contentsOfFile: iconFilePath)
    }
    else if let iconName = (bundle.infoDictionary?["CFBundleIconName"]) as? String,
            let image = bundle.image(forResource: iconName)
    {
      iconImage = image
    }
    
    iconImage?.size = NSSize(width: 36, height: 36)
    if iconImage == nil {
      print("invalid iconImage of \(name) URL:\(bundleURL!)")
      return NSImage(named:"egg+question")!
    }
    return iconImage!
  }
  
  func updateLaunchOption(newOption: LaunchOption) {
    if newOption != launchOption {
      launchOption = newOption
      
      AppState.saveFlag = true
    }
  }
  
  var debugDescription: String {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let json = try! encoder.encode(self)
    return String(data: json, encoding: String.Encoding.utf8)!
  }
}

extension AppItem {
  static let testAppItems = [
    AppItem(metaData: NSMetadataItem(url: URL(string: "file:///Applications/Google%20Chrome.app")!)!)!,
    AppItem(metaData: NSMetadataItem(url: URL(string: "file:///Applications/Safari.app")!)!)!,
  ]
}
