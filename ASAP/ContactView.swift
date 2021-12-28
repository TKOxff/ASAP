//
//  ContactView.swift
//  ASAP
//
//  Created by TKOxff on 2021/08/23.
//

import SwiftUI


extension NSTextField {
  open override var focusRingType: NSFocusRingType {
    get { .none }
    set { }
  }
}

// Input form for sending message for Slack
//
struct ContactView: View {
  @State private var name: String = ""
  @State private var contents: String = "Input\nText\nHere"
  
  var body: some View {
    VStack {
      Text("Let me know your opinion!")
        .foregroundColor(Color.gray)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
      
      TextField("Enter your name", text: $name)
        .textFieldStyle(PlainTextFieldStyle())
        .padding(10)
        .font(.headline)
        .background(Color("TooltipBgColor"))
        .cornerRadius(5.0)
      
      TextView(text: $contents)
        .padding(10)
        .background(Color("TooltipBgColor"))
        .cornerRadius(5.0)
      
      Button(action: {
        sendMessageToSlack(name: name, msg: contents)
      }, label: {
        Text("Send")
      })
    }
    .frame(width: 400, height: 300, alignment: .topLeading)
    .padding()
  }
}

struct ContactView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContactView()
        .environment(\.colorScheme, .dark)
      ContactView()
        .environment(\.colorScheme, .light)
    }
  }
}

//
// Settings -> App Sandbox -> Outgoing Connections (Clint) [On]
//
func sendMessageToSlack(name: String, msg: String) -> Void {
  
  let url = URL(string: "https://hooks.slack.com/services/get it from DOTO doc")
  guard let reqUrl = url else {
    print("URL is bad")
    return
  }
  
  var req = URLRequest(url: reqUrl)
  req.httpMethod = "POST"
  
  let params = ["text" : "New Opinion from ASAP\n name:" + name + "\n Contents:\n" + msg ]
  let jsonData = try? JSONEncoder().encode(params)
  req.httpBody = jsonData
  
  req.setValue("application/json", forHTTPHeaderField: "Content-Type")
  req.setValue("application/json", forHTTPHeaderField: "Accept")
  
  let task = URLSession.shared.dataTask(with: req) { (data, res, error) in
    guard let data = data else {
      print("fail error:", error!)
      return
    }
    print("data: \(String(describing: String(bytes: data, encoding: .utf8)))")

    guard error == nil else {
      print("network error:", error!)
      return
    }
    
//    do {
//      let obj = try JSONDecoder().decode(String.self, from: data)
//      print(obj)
//    } catch let error {
//      print("decode error:", error)
//    }
  }
  task.resume()
}
