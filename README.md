# ASAP Shortcuts

ASAP is a global shortcuts App for macOS, written in Swift and SwiftUI.

<img src="public/asap.png" width=500>

Key Features  
  - Spawn a New Window of apps on the current Space ASAP.
  - Launch system apps like System Preferences and Finder.

## Demo

New Window on the current space with a single shortcut press.

<img src="public/asap_demo.gif" width=500>

No more! mouse moving and clicking for New Window menu.

## About ASAP

Options  
 * Open the existing app first (default)  
   If the app exists in another space then you get dragged to that space. (macOS behavior)
   
 * Always spawn a New Window on the current desktop  
   You could register the same app with different options and shortcut  
   (Some apps does not allow multiple windows)

Notice  
There is already taken global shorcuts by macOS (ex opt+cmd+D is Dock Hiding)  
You can manage it from System Preferences -> Keyboard -> Shortcuts

## Installation

It's available on [App Store](https://apps.apple.com/us/app/asap-shortcuts/id1558863477)

## Dependences  

ASAP uses [MASShortcut](https://github.com/shpakovski/MASShortcut) for keyboard shortcut recording.

## Requirements

ASAP supports macOS v10.15+

## License

ASAP is licensed under the terms of the [MIT License](LICENSE).
