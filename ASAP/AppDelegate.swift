//
//  AppDelegate.swift
//  ASAP
//
//  Created by TKOxff on 2021/03/06.
//

import Cocoa
import SwiftUI
import MASShortcut

@main
class AppDelegate: NSObject, NSApplicationDelegate {
  
  var window: NSWindow!
  var appState = AppState()
  
  var statusItem: NSStatusItem?
  @IBOutlet weak var statusMenu: NSMenu?
  @IBOutlet weak var firstMenuItem: NSMenuItem?
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    
    createContentViewAsMainWindow()
    
    initLaunchAtLogin()
  }
  
  private func createContentViewAsMainWindow() {
    
    // todo: check it again..
    if MASShortcutMonitor.shared() != nil {}
    
    // Create the SwiftUI view that provides the window contents.
    let contentView = ContentView().environmentObject(appState)
    
    // Create the window and set the content view.
    window = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
      styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
      backing: .buffered, defer: false)
    
    window.isReleasedWhenClosed = false
    window.center()
    window.setFrameAutosaveName("Main Window")
    window.contentView = NSHostingView(rootView: contentView)
    window.makeKeyAndOrderFront(nil)
    // should be option?
    window.collectionBehavior = NSWindow.CollectionBehavior.canJoinAllSpaces
    window.title = Bundle.main.appName + " - Global Shortcuts"

#if DEBUG
#else
    // hide window
    window.orderOut(nil)
#endif
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    statusItem?.button?.image = NSImage(named: "StatusIcon")
    if let menu = statusMenu {
      statusItem?.menu = menu
    }
  }
  
  @IBAction func menuPreferenceAction(_ sender: NSMenuItem) {
    window.orderFrontRegardless()
    
    AppStoreReview.checkRequest()
  }
  
  func applicationWillTerminate(_ aNotification: Notification) {
    appState.saveApps()
  }
}
