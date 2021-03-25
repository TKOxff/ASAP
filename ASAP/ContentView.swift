//
//  ContentView.swift
//  ASAP
//
//  Created by TKOxff on 2021/03/06.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var appState: AppState
  @Environment(\.colorScheme) var colorScheme
  
  @State private var selectedApp : AppItem?
  
  
  var body: some View {
    VStack {
      List(self.appState.appItems, id:\.self, selection: $selectedApp) { app in
        AppRow(item: app)
      }
      
      ZStack {
        HStack {
          AddButton()
          RemoveButton(selectedApp: self.$selectedApp)
        }
        AppOptionView()
      }
      .frame(maxWidth: .infinity)
    }
    .background(backgroundColor)
    .frame(minWidth: 450, maxWidth: 600, minHeight: 200, maxHeight: .infinity)
    
  }//body
  
  var backgroundColor: Color {
    colorScheme == .dark ? Color.clear : Color.white
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .frame(width: 500)
      .environmentObject(AppState())
  }
}
