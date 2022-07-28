//
//  BookwormApp.swift
//  Bookworm
//
//  Created by 김호준 on 2022/07/28.
//

import SwiftUI

@main
struct BookwormApp: App {
  @StateObject private var dataController = DataController()
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, dataController.container.viewContext)
    }
  }
}
