//
// Created by me


import SwiftUI

struct AddFaceView: View {
    
    @EnvironmentObject var store: RootStore
    @Environment(\.presentationMode) var presentationMode
    @State private var image: UIImage?
    @State private var name = ""
    @State private var showPicker = false
    
    var body: some View {
        Form {
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Button(image == nil ? "Pick Face" : "Change Face") {
                self.showPicker = true
            }
            
            TextField("Name", text: $name)
            Button("Add Face", action: addFace)
                .disabled(!isValid)
        }
        .sheet(isPresented: $showPicker) {
            ImagePicker(image: self.$image)
        }
    }
    
    private func addFace() {
        guard let data = image?.jpegData(compressionQuality: 0.8) else { return }
        let location = store.state.locationState.lastKnownLocation
        let face = Face(id: UUID().uuidString, name: name, coordinate: location)
        
        do {
            try data.write(to: File.getDocumentsDirectory().appendingPathComponent(face.id), options: [.atomicWrite, .completeFileProtection])
            self.store.commit(FacesMutation.add(face))
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            //TODO: show error
        }
    }
    
    private var isValid: Bool {
        return image != nil && !name.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

struct AddFaceView_Previews: PreviewProvider {
    static var previews: some View {
        AddFaceView()
    }
}
