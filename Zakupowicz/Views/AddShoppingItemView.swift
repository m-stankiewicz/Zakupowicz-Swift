import SwiftUI

struct AddShoppingItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AddShoppingItemViewModel
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Item Name", text: $viewModel.name)
                Picker("Priority", selection: $viewModel.priority) {
                    ForEach(ShoppingItem.Priority.allCases, id: \.self) { priority in
                        Text(priority.rawValue.capitalized).tag(priority)
                    }
                }
            }
            .navigationTitle("New Item")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        viewModel.addNewItem()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

