//
//  main.swift
//  LoginLauncher
//
//  Created by TKOxff on 2021/03/13.
//

import Cocoa

let delegate = LoginLauncherAppDelegate()
NSApplication.shared.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
