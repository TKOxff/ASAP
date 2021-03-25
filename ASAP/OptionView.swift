//
//  OptionView.swift
//  AppSpawnKey
//
//  Created by TKOxff on 2021/03/11.
//

import SwiftUI

struct OptionView: View {
  @Binding var isVisible: Bool
  @ObservedObject var appItem: AppItem
  @State private var launchOption = LaunchOption.OpenExistOne
  
  var body: some View {
    VStack {
      HStack {
        Image(nsImage: appItem.icon)
        Text(appItem.name)
      }
      .padding(.top, 8)
      Divider()
      
      VStack(alignment: .leading) {
        Text("How to launch the app")
        HStack {
          Picker("", selection: $launchOption) {
            Text("Open the exist one first (default)").tag(LaunchOption.OpenExistOne)
            Text("Always Spawn a new instance at current desktop").tag(LaunchOption.NewInstance)
          }
          .pickerStyle(RadioGroupPickerStyle())
          Spacer()
        }
      }
      .padding()
      .frame(maxWidth: .infinity)
      
      Spacer()
      
      HStack {
        Button("OK", action: {
          self.isVisible = false
          self.appItem.updateLaunchOption(newOption: launchOption)
        })
        .padding()
        Button("Cancel", action: {
          self.isVisible = false
        })
        .padding()
      }
    }
    .onAppear() {
      launchOption = appItem.launchOption
    }
    .frame(width: 400, height: 250, alignment: .leading)
  }
}

struct OptionView_Previews: PreviewProvider {
  static var previews: some View {
    OptionView(isVisible: .constant(true), appItem: AppItem.testAppItems[0])
  }
}
