//
//  TooltipView.swift
//  ASAP
//
//  Created by TKOxff on 2021/08/22.
//

import SwiftUI

struct TooltipView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @Binding var isShow: Bool
  
  var fgColor : Color {
    colorScheme == .dark ? Color("TooltipBgColor") : Color.gray
  }
  
  var body: some View {
    if isShow {
      Text("You can add a new App with the [+] button below.")
        .padding()
        .foregroundColor(Color("TooltipFgColor"))
        .background(Color("TooltipBgColor"))
        .cornerRadius(10)
    } else {
      Text("")
    }
  }
}

struct TooltipView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TooltipView(isShow: .constant(true))
      .environment(\.colorScheme, .dark)
      TooltipView(isShow: .constant(true))
      .environment(\.colorScheme, .light)
    }
    .padding()
  }
}
