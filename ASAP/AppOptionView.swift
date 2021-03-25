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
      print("isStartAtLogin: \(AppState.isStartAtLogin)")
    }
  }
}

struct AppOptionView: View {
  @ObservedObject var vm = AppOptionModel()
  
  var body: some View {
    HStack {
      Text("Launch at login")
      CheckBox(enable: self.$vm.startAtLogin)
    }
    .foregroundColor(.gray)
    .frame(maxWidth: .infinity, alignment: .trailing)
    .padding()
    .padding(.trailing)
  }
}

struct AppOptionView_Previews: PreviewProvider {
  static var previews: some View {
    AppOptionView()
  }
}
