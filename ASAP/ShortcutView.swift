//
//  ShortcutView.swift
//  AppSpawnKey
//
//  Created by TKOxff on 2021/03/05.
//

import Foundation
import SwiftUI
import MASShortcut


public struct ShortcutView: NSViewRepresentable {
  let masView: MASShortcutView = MASShortcutView()
  var appItem: AppItem
  
  public func makeNSView(context: Context) -> MASShortcutView {
    
    masView.shortcutValueChange = self.doShortcutValueChange
    masView.shortcutValue = appItem.shortcut
    registerShortcut(appItem.shortcut)
    
    return masView
  }
  
  public func updateNSView(_ nsView: MASShortcutView, context: Context) {
  }
  
  public func doShortcutValueChange(_ sender: MASShortcutView?) {
    let newShortcut = sender?.shortcutValue
    
    if newShortcut != appItem.shortcut {
      print("shortcut has changed from \(appItem.shortcut?.description ?? "nil") to \(newShortcut?.description ?? "nil") \(appItem.name)")
      
      if (appItem.shortcut != nil) {
        unregisterShortcut(appItem.shortcut)
      }
      
      registerShortcut(newShortcut)
      appItem.shortcut = newShortcut
      
      AppState.saveFlag = true
    }
  }
  
  func registerShortcut(_ shortcutVal: MASShortcut?) {
    guard let shared = MASShortcutMonitor.shared(),
          let shortcut = shortcutVal else {
      return
    }
    
    let ret = shared.register(shortcut, withAction: doOpenApp)
    print("register shortcut: \(shortcut.description) \(appItem.name) \(ret ? "OK" : "Fail")")
  }
  
  func unregisterShortcut(_ shortcutVal: MASShortcut?) {
    guard let shared = MASShortcutMonitor.shared(),
          let shortcut = shortcutVal else {
      return
    }
    
    shared.unregisterShortcut(shortcut)
    print("unregister shortcut: \(shortcut.description) \(appItem.name) OK")
  }
  
  public func doOpenApp() {
    if appItem.enable == false {
      print("\(appItem.name) is not enabled")
      return
    }
    
    let config = NSWorkspace.OpenConfiguration()
    
    if appItem.launchOption == LaunchOption.NewInstance {
      config.createsNewApplicationInstance = true
      
      if AppState.isInKeyDownDelaying() {
        return
      }
    }
    
    NSWorkspace.shared.openApplication(at: appItem.bundleURL!, configuration: config, completionHandler: nil)
  }
}

