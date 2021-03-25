//
//  AppDelegate.swift
//  ASAPLauncher
//
//  Created by TKOxff on 2021/03/13.
//

import Cocoa
import ServiceManagement


class LoginLauncherAppDelegate: NSObject, NSApplicationDelegate {
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    print("LoginLauncherAppDelegate begin")
    
    let mainAppIdentifier = "TKOxff.ASAP"
    let runningApps = NSWorkspace.shared.runningApplications
    
    let isRunning = !runningApps.filter { $0.bundleIdentifier == mainAppIdentifier }.isEmpty

    if !isRunning {
      DistributedNotificationCenter.default().addObserver(self,
                                                          selector: #selector(terminate),
                                                          name: .killLauncher,
                                                          object: mainAppIdentifier)
      
      let path = Bundle.main.bundlePath as NSString
      var components = path.pathComponents
      components.removeLast()
      components.removeLast()
      components.removeLast()
      components.append("MacOS")
      // TODO: read from env config..
      components.append("ASAP")
      
      let newPath = NSString.path(withComponents: components)
      print(newPath.description)

      NSWorkspace.shared.launchApplication(newPath)
    }
    else {
      self.terminate()
      
    }
  }
  
  @objc func terminate() {
    print("LoginLauncherAppDelegate terminate")
    
    NSApp.terminate(nil)
  }
}


extension Notification.Name {
  static let killLauncher = Notification.Name("killLauncher")
}
