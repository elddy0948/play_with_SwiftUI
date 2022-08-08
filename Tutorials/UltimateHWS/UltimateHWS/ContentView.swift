//
//  ContentView.swift
//  UltimateHWS
//
//  Created by 김호준 on 2022/07/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      TabView {
        HomeView()
          .tabItem({
            Image(systemName: "house")
            Text("Home")
          })
        ProjectView(showClosedProjects: false)
          .tabItem({
            Image(systemName: "list.bullet")
            Text("Open")
          })
        ProjectView(showClosedProjects: true)
          .tabItem({
            Image(systemName: "checkmark")
            Text("Closed")
          })
      }
    }
}

struct ContentView_Previews: PreviewProvider {
  static var dataController = DataController.preview
  
  static var previews: some View {
    ContentView()
      .environment(\.managedObjectContext, dataController.container.viewContext)
      .environmentObject(dataController)
  }
}
