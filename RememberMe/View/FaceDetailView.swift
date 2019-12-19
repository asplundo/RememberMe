//
// Created by me


import SwiftUI

struct FaceDetailView: View {
    
    let face: Face
    @State private var mapViewPresented = false
    
    var body: some View {
            VStack {
                Text(face.name)
                    .font(.headline)
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                if face.coordinate != nil {
                    Button("Show where") {
                        self.mapViewPresented = true
                    }
                }
                Spacer()
            }.sheet(isPresented: $mapViewPresented) {
                ZStack(alignment: .topTrailing) {
                    MapView(coordinate: self.face.coordinate!)
                    Button("close") {
                        self.mapViewPresented = false
                    }
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .offset(x: -10, y: 10)

                    
                }
                
            }
    }
    
    var image: Image {
        if let uiImage = face.imageData {
            return Image(uiImage: uiImage)
        }
        
        return Image(systemName: "person.fill")
    }
}

struct FaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FaceDetailView(face: Face(id: "test", name: "Nille"))
    }
}
