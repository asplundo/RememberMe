//
// Created by me
  

import Foundation
import Fluxus

let rootStore = RootStore()

class RootStore: ObservableObject {
    
    @Published var state = RootState()
    
    func commit(_ mutation: Mutation) {
        switch mutation {
        case is FacesMutation:
            state.facesState = FacesCommiter().commit(state: state.facesState, mutation: mutation as! FacesMutation)
        case is LocationMutation:
            state.locationState = LocationCommiter().commit(state: state.locationState, mutation: mutation as! LocationMutation)
        default:
            fatalError("Unexpected mutation")
        }
    }
    
}
