//
//  AddButton.swift
//  AppSpawnKey
//
//  Created by TKOxff on 2021/03/06.
//

import SwiftUI

struct AddButton: View {
  @EnvironmentObject var appState: AppState

  var body: some View {
    Button(action: {
      let newApp = openPanelModal()
      if (newApp != nil) {
        appState.addApp(newApp)
        appState.saveApps()
      }
    }, label: {
      Text("+")
    })
    .padding([.top, .bottom])
  }//body
}

struct AddButton_Previews: PreviewProvider {
  static var previews: some View {
    AddButton()
      .environmentObject(AppState())
  }
}

func openPanelModal() -> AppItem? {
  
  let openPanel = NSOpenPanel()
  openPanel.allowsMultipleSelection = false
  openPanel.canChooseDirectories = true
  openPanel.canChooseFiles = true
  
  if let appDir = NSSearchPathForDirectoriesInDomains(.applicationDirectory, .localDomainMask, true).first {
    openPanel.directoryURL = URL(fileURLWithPath: appDir)
  }
  
  if (openPanel.runModal() ==  NSApplication.ModalResponse.OK) {
    if (openPanel.url  != nil) {
      print(openPanel.url!.description)
      
      let metaDataItem = NSMetadataItem(url: openPanel.url!)
      return AppItem(metaData: metaDataItem!)
    }
  }
  
  return nil
}
