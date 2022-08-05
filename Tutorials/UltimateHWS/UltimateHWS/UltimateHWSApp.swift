import SwiftUI

@main
struct UltimateHWSApp: App {
  @StateObject var dataController: DataController
  
  init() {
    let dataController = DataController()
    _dataController = StateObject(wrappedValue: dataController)
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
