//
//  AppOptionView.swift
//  AppSpawnKey
//
//  Created by TKOxff on 2021/03/11.
//

import SwiftUI

class AppOptionModel: ObservableObject {
  @Published var startAtLogin: Bool = AppState.isStartAtLogin {
    didSet {
      AppState.updateStartAtLogin(flag: self.startAtLogin)
    }
  }
}

struct AppOptionView: View {
  @ObservedObject var vm = AppOptionModel()
  @Binding var isShow: Bool

  var body: some View {
    HStack {
      CheckBox(enable: self.$isShow)
      Text("Show Tooltip")
      
      Spacer();
      
      Text("Launch at login")
      CheckBox(enable: self.$vm.startAtLogin)
    }
    .foregroundColor(.gray)
    .padding()
    .padding([.trailing, .leading])
  }
}

struct AppOptionView_Previews: PreviewProvider {
  static var previews: some View {
    AppOptionView(
      isShow: .constant(true)
    )
//      .environmentObject(AppState())
  }
}
