//
// Created by me
  

import Foundation
import Fluxus

enum FacesMutation: Mutation {
    case add(Face)
}

struct FacesCommiter: Committer {
    func commit(state: FacesState, mutation: FacesMutation) -> FacesState {
        var newState = state
        switch mutation {
        case .add(let face):
            newState.add(face: face)
            newState.faces = newState.faces.sorted()
        }
        return newState
    }
}

