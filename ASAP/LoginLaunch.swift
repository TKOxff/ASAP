//
//  LoginLaunchHelper.swift
//  AppSpawnKey
//
//  Created by TKOxff on 2021/03/14.
//

import Cocoa
import ServiceManagement


let launcherAppId = "TKOxff.ASAPLauncher"


public func initLaunchAtLogin() {
  
  let runningApps = NSWorkspace.shared.runningApplications
  let isRunning = !runningApps.filter { $0.bundleIdentifier == launcherAppId }.isEmpty
    
  SMLoginItemSetEnabled(launcherAppId as CFString, true)

  if isRunning {
    print("Launcher is Running and kill it")
      DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier!)
  }
}

public func EnableLoginLauncher(enable: Bool) {
  
  let ret = SMLoginItemSetEnabled(launcherAppId as CFString, enable)
  print("updateStartAtLogin ret: \(ret)")
}

extension Notification.Name {
  static let killLauncher = Notification.Name("killLauncher")
}
