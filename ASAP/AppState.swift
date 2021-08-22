//
//  AppState.swift
//  AppSpawnKey
//
//  Created by TKOxff on 2021/03/06.
//

import Foundation
import MASShortcut
import ServiceManagement


class AppState: ObservableObject {
  
  @Published var appItems: [AppItem] = []
  static var saveFlag = false
  static var lastKeyDownTime: Int64 = 0
  
  @UserDefault("isFirstAppLaunching", defaultValue: true)
  static var isFirstAppLaunching: Bool

  @UserDefault("isShowTooltip", defaultValue: true)
  static var isShowTooltip: Bool
  
  @UserDefault("isStartAtLogin", defaultValue: false)
  static var isStartAtLogin: Bool

  init() {
    print("AppState init")
    loadApps()
    
    print(Bundle.main.appVersion)
    
    #if DEBUG
    //initDebugSetting()
    #endif
    
    if AppState.isFirstAppLaunching || appItems.count == 0 {
      installDefaultApps()
      AppState.isFirstAppLaunching = false
      
      AppStoreReview.firstLaunchDate = Date()
      print("firstLaunchDate:\(AppStoreReview.firstLaunchDate)")
    }
    
    print("load isShowTooltip:\(AppState.isShowTooltip)")
  }
  
  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  var savePath: URL {
    return getDocumentsDirectory().appendingPathComponent("apps")
  }
  
  func saveApps() {
    print("AppState saveApps")
    
    if AppState.saveFlag == false {
      print("no need to save")
      return
    }
    
    printAppDebug()
    
    do {
      let apps = try PropertyListEncoder().encode(appItems)
    
      let data = try NSKeyedArchiver.archivedData(withRootObject: apps, requiringSecureCoding: false)
      
      print("savePath:" + savePath.absoluteString)
      try data.write(to: savePath)
    }
    catch
    {
      print("Couldn't write file")
    }
    
    AppState.saveFlag = false
  }
    
  func loadApps() {
    print("AppState loadApps")
    print(savePath)
    
    guard let data = try? Data(contentsOf: savePath),
          let loadData = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Data else {
      return
    }
    
    let apps = try! PropertyListDecoder().decode([AppItem].self, from: loadData)
    appItems = apps
    
//    printAppDebug()
    
    print("AppState loadApps count:" + appItems.count.description)
  }
 
  func addApp(_ appItem: AppItem?) {
    if let app = appItem {
      appItems.append(app)
      
      AppState.saveFlag = true
    }
  }
  
  func deleteApp(app: AppItem) {
    
    if let index = appItems.firstIndex(of: app) {
      appItems.remove(at: index)
      
      AppState.saveFlag = true
    }
  }
  
  private func installDefaultApps() {
    print("installDefaultApps at first launch")
    AppState.saveFlag = true
    
    let optCmdFlags = NSEvent.ModifierFlags([.command, .option])
    
    let defaultApps = [
      (
        app: NSMetadataItem(url: URL(string: "file:///System/Applications/System%20Preferences.app")!),
        shortcut: MASShortcut.init(keyCode: Int(kVK_ANSI_Comma), modifierFlags: optCmdFlags)
      ),
      (
        app: NSMetadataItem(url: URL(string: "file:///System/Library/CoreServices/Finder.app")!),
        shortcut: MASShortcut.init(keyCode: Int(kVK_ANSI_N), modifierFlags: optCmdFlags)
      )
    ]

    for (item, shortcut) in defaultApps {
      appItems.append(AppItem(metaData: item!, shortcut: shortcut!)!)
    }
  }
  
  static func isInKeyDownDelaying() -> Bool {
    let now = Date().currentTimeMS
    
    let elasped = now - AppState.lastKeyDownTime
    if elasped < 500 {
      print("KeyDown delaying BLOCKED:\(elasped)")
      return true
    }
    
    AppState.lastKeyDownTime = now
    
    return false
  }
  
  static func updateStartAtLogin(flag: Bool) {
    AppState.isStartAtLogin = flag
    
    EnableLoginLauncher(enable: flag)
  }

  static func updateShowTooltip(flag: Bool) {
    AppState.isShowTooltip = flag
  }

  private func printAppDebug() {
#if DEBUG
    for app in appItems {
      print(app.debugDescription)
    }
#endif
  }

}

extension AppState {
  #if DEBUG
  func initDebugSetting() {
    AppState.isFirstAppLaunching = true
    
    AppStoreReview.initDebugSetting()
  }
  #endif
}

