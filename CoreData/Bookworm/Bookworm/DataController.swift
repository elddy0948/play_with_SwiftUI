import CoreData

class DataController: ObservableObject {
  let container = NSPersistentContainer(name: "Bookworm")
  init() {
    container.loadPersistentStores(completionHandler: { description, error in
      if let error = error {
        print("Error occured when load persistent store : \(error.localizedDescription)")
      }
    })
  }
}
