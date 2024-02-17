import SwiftUI

struct AddShoppingListView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AddShoppingListViewModel
    @State private var title = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("List Title", text: $title)
            }
            .navigationTitle("New List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        viewModel.addShoppingList(title: title)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
