import CoreData
import SwiftUI

class DataController: ObservableObject {
  let container: NSPersistentCloudKitContainer
  
  init(inMemory: Bool = false) {
    container = NSPersistentCloudKitContainer(name: "Main")
    
    if inMemory {
      container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    }
    
    container.loadPersistentStores(completionHandler: { storeDescription, error in
      if let error = error {
        fatalError("Error occured while loading persistent stores : \(error.localizedDescription)")
      }
    })
  }
  
  static var preview: DataController = {
    let dataController = DataController(inMemory: true)
  
    do {
      try dataController.createSampleData()
    } catch {
      fatalError("Fatal error creating preview : \(error.localizedDescription)")
    }
    
    return dataController
  }()
  
  func createSampleData() throws {
    let viewContext = container.viewContext
    
    for i in 1 ... 5 {
      let project = Project(context: viewContext)
      project.title = "Project \(i)"
      project.items = []
      project.creationDate = Date()
      project.closed = Bool.random()
      
      for j in 1 ... 10 {
        let item = Item(context: viewContext)
        item.title = "Item \(j)"
        item.creationDate = Date()
        item.completed = Bool.random()
        item.priority = Int16.random(in: 1 ... 3)
        item.project = project
      }
    }
    
    try viewContext.save()
  }
  
  func save() {
    if container.viewContext.hasChanges {
      try? container.viewContext.save()
    }
  }
  
  func delete(_ object: NSManagedObject) {
    container.viewContext.delete(object)
  }
  
  func deleteAll() {
    let fetchRequestForItem: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
    let batchDeleteRequestForItem = NSBatchDeleteRequest(fetchRequest: fetchRequestForItem)
    _ = try? container.viewContext.execute(batchDeleteRequestForItem)
    
    let fetchRequestForProject: NSFetchRequest<NSFetchRequestResult> = Project.fetchRequest()
    let batchDeleteRequestForProject = NSBatchDeleteRequest(fetchRequest: fetchRequestForProject)
    _ = try? container.viewContext.execute(batchDeleteRequestForProject)
  }
}
