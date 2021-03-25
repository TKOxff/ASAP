//
//  RemoveButton.swift
//  AppSpawnKey
//
//  Created by TKOxff on 2021/03/06.
//

import SwiftUI

struct RemoveButton: View {
  @EnvironmentObject var appState: AppState
  @Binding var selectedApp: AppItem?

  var enable: Bool {
    selectedApp != nil
  }
  
  var body: some View {
    Button(action: {
      if selectedApp != nil {
        self.appState.deleteApp(app: selectedApp!)
      }
    }, label: {
      Text("-")
    })
    .opacity(enable ? 1.0 : 0.4)
    .padding([.top, .bottom])
  }
}

struct RemoveButton_Previews: PreviewProvider {
  static var previews: some View {
    RemoveButton(selectedApp: .constant(nil))
      .environmentObject(AppState())
  }
}
