//
//  CheckBox.swift
//  AppSpawnKey
//
//  Created by TKOxff on 2021/03/07.
//

import SwiftUI


struct CheckBox: View {
  @Binding var enable: Bool
  
  // AppOptionView에서 사용할때 이미지가 변하지 않는 문제 대용, 멤버 변수로 변경하니 해결..
  // 멤버로 만들어 두면 구조체 생성시 한번만 만들면 되니 더 타당하긴 하다.
  let checkedImage = NSImage(named: "checkbox.checked")!
  let uncheckedImage = NSImage(named: "checkbox")!
  
  var checkBoxImage: NSImage {
    let image = enable ? checkedImage : uncheckedImage
    image.isTemplate = true
    return image
  }
  
  var body: some View {
    Button(action:{
      enable.toggle()
    }) {
      Image(nsImage: checkBoxImage)
        .resizable()
        .frame(width: 16, height: 16)
    }
    .buttonStyle(PlainButtonStyle())
  }
}

struct CheckBox_Previews: PreviewProvider {
  static var previews: some View {
    CheckBox(enable: .constant(true))
  }
}
