//
//  AddBookView.swift
//  Bookworm
//
//  Created by 김호준 on 2022/07/28.
//

import SwiftUI
import CoreData

struct AddBookView: View {
  @Environment(\.managedObjectContext) var moc
  
  @State private var title = ""
  @State private var author = ""
  @State private var rating = 3
  @State private var genre = ""
  @State private var review = ""
  
  let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Name of book", text: $title)
          TextField("Author's name", text: $author)
          Picker("Genre", selection: $genre) {
            ForEach(genres, id:\.self) { Text ($0) }
          }
        }
        Section {
          TextEditor(text: $review)
          Picker("Rating", selection: $rating) {
            ForEach(0 ..< 6) { Text(String($0)) }
          }
        } header: {
          Text("Write Review")
        }
        Section {
          Button("Save") {
            let newBook = Book(context: moc)
            newBook.id = UUID()
            newBook.title = title
            newBook.author = author
            newBook.genre = genre
            newBook.rating = Int16(rating)
            newBook.review = review
            
            try? moc.save()
          }
        }
      }
      .navigationTitle("Add Book")
    }
  }
}

struct AddBookView_Previews: PreviewProvider {
  static var previews: some View {
    AddBookView()
  }
}
