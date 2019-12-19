//
// Created by me
  

import Foundation
import Fluxus
import MapKit

enum LocationMutation: Mutation {
    case update(CLLocationCoordinate2D)
}

struct LocationCommiter: Committer {
    func commit(state: LocationState, mutation: LocationMutation) -> LocationState {
        var newState = state
        switch mutation {
        case .update(let location):
            newState.lastKnownLocation = location
        }
        
        return newState
    }
}
