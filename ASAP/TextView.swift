//
//  TextView.swift
//  ASAP
//
//  Created by TKOxff on 2021/08/24.
//

import Foundation
import SwiftUI
import AppKit

// TextEditor for versions prior to macOS 11.
struct TextView: NSViewRepresentable {
  @Binding var text: String
  
  func makeNSView(context: NSViewRepresentableContext<Self>) -> NSTextView {
    let textView = NSTextView()
    textView.isEditable = true
    textView.isSelectable = true
    textView.backgroundColor = .clear
    return textView
  }
  
  func updateNSView(_ nsView: NSTextView, context: NSViewRepresentableContext<Self>) {
    nsView.string = text
  }
}
