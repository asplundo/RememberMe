//
// Created by me


import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var rootStore: RootStore
    
    var body: some View {
        NavigationView {
            List(rootStore.state.facesState.faces) { face in
                NavigationLink(destination: FaceDetailView(face: face)) {
                    FaceRow(face: face)
                }
            }
            .navigationBarTitle("RememberMe")
            .navigationBarItems(trailing: NavigationLink(destination: AddFaceView()) {
                Text("Add face")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
