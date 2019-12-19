//
// Created by me


import SwiftUI

struct FaceRow: View {
    
    let face: Face
    
    var body: some View {
        HStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 44, height: 44)
                .overlay(Circle().stroke(lineWidth: 2))
            Text(face.name)
            
        }
    }
    
    var image: Image {
        if let uiImage = face.imageData {
            return Image(uiImage: uiImage)
        }
        
        return Image(systemName: "person.fill")
    }
}

struct FaceRow_Previews: PreviewProvider {
    static var previews: some View {
        FaceRow(face: Face(id: UUID().uuidString, name: "Earl"))
    }
}
