//
//  AppRow.swift
//  MacShortcut
//
//  Created by TKOxff on 2021/03/03.
//

import SwiftUI
import MASShortcut

struct AppRow: View {
  
  @EnvironmentObject var appState: AppState
  @Environment(\.colorScheme) var colorScheme
  @ObservedObject var item: AppItem
  @State private var sheetIsShowing = false
  
  var accentColor: Color {
    colorScheme == .dark ? .black : .white
  }
  
  var body: some View {
    HStack{
      CheckBox(enable: $item.enable)
        .opacity(0.5)
      
      Image(nsImage: item.icon)
      Text(item.name)
      
      Spacer()
      
      if item.launchOption == LaunchOption.NewInstance {
        Text(" S ")
          .bold()
          .frame(width: 15, height: 15)
          .foregroundColor(accentColor.opacity(0.8))
          .padding(1)
          .background(Color.white.opacity(0.8))
          .cornerRadius(20.0)
      }
      
      Button(action: {
        sheetIsShowing.toggle()
      }, label: {
        HStack {
          Text("Option")
            .font(.caption)
            .foregroundColor(.gray)
            .padding([.top, .bottom], 1)
            .padding([.leading, .trailing], 15)
            .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
            )
        }
        .contentShape(Rectangle())
      })
      .buttonStyle(PlainButtonStyle())
      
      ShortcutView(appItem: item)
        .frame(width: 150, height: 40)
    }
    .padding(10)
    .sheet(isPresented: self.$sheetIsShowing) {
      OptionView(isVisible: self.$sheetIsShowing, appItem: self.item)
    }
  }//body
}

struct AppRow_Previews: PreviewProvider {
  static var previews: some View {
    AppRow(item: AppItem.testAppItems[0])
      .frame(width: 500)
  }

}
