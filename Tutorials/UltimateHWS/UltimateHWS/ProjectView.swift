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
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct ProjectView_Previews: PreviewProvider {
  static var previews: some View {
    ProjectView(showClosedProjects: false)
  }
}
