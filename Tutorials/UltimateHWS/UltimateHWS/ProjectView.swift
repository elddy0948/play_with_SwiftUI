import SwiftUI

struct ProjectView: View {
  let showClosedProjects: Bool
  let projects: FetchRequest<Project>
  
  init(showClosedProjects: Bool) {
    self.showClosedProjects = showClosedProjects
    projects = FetchRequest<Project>(
      entity: Project.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)
      ], predicate: NSPredicate(format: "closed = %d", showClosedProjects),
      animation: nil
    )
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(projects.wrappedValue) { project in
          Section(content: {
            ForEach(project.items?.allObjects as? [Item] ?? []) { item in
              Text(item.title ?? "")
            }
          }, header: {Text(project.title ?? "")})
          
        }
      }
      .listStyle(InsetGroupedListStyle())
      .navigationTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
    }
  }
}

struct ProjectView_Previews: PreviewProvider {
  static var dataController = DataController.preview
  
  static var previews: some View {
    ProjectView(showClosedProjects: false)
      .environment(\.managedObjectContext, dataController.container.viewContext)
      .environmentObject(dataController)
  }
}
