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
//  var contactView: ContactView!
  
  var statusItem: NSStatusItem?
  @IBOutlet weak var statusMenu: NSMenu?
  @IBOutlet weak var firstMenuItem: NSMenuItem?
  @IBOutlet weak var contactMenuItem: NSMenuItem?
  
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
    
//    contactView = ContactView()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    statusItem?.button?.image = NSImage(named: "StatusIcon")
    if let menu = statusMenu {
      statusItem?.menu = menu
    }
  }
  
  // Open the main window of ASAP
  @IBAction func menuPreferenceAction(_ sender: NSMenuItem) {
    window.orderFrontRegardless()
    
    AppStoreReview.checkRequest()
  }
  
  
  @IBAction func menuContactAction(_ sender: NSMenuItem) {
    
    SendEmail.send()
    
    // Open a sub window (POSTPONED)
    // TODO: open a window at once.
    //    let ctrl = NSHostingController(rootView: contactView)
    //    let win = NSWindow(contentViewController: ctrl)
    //    win.contentViewController = ctrl
    //    win.title = "ASAP - Contact Developer"
    //    win.isReleasedWhenClosed = false
    //    win.makeKeyAndOrderFront(sender)
    //    win.orderFrontRegardless()
    //    win.center()
  }
  
  func applicationWillTerminate(_ aNotification: Notification) {
    appState.saveApps()
  }
}

class SendEmail: NSObject {
  static func send() {
    let service = NSSharingService(named: NSSharingService.Name.composeEmail)!
    service.recipients = ["tkoxff@gmail.com"]
    service.subject = "About ASAP shortcuts App"
    service.perform(withItems: [
      "Let me know your opinion.\n당신의 의견을 알려주세요.\nご意見をお聞かせください。"
    ])
  }
}
