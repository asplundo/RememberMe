//
// Created by me
  

import Foundation
import Fluxus

struct FacesState: FluxState {
    
    private static let fileName = "faces"
    
    var faces: [Face]
    
    init() {
        self.faces = []
        let file = File.getDocumentsDirectory().appendingPathComponent(FacesState.fileName)
        if File.fileExists(at: file.path) {
            do {
                let data = try Data(contentsOf: file)
                self.faces = try JSONDecoder().decode([Face].self, from: data).sorted()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    mutating func add(face: Face) {
        do {
            faces.append(face)
            let data = try JSONEncoder().encode(faces)
            try data.write(to: File.getDocumentsDirectory().appendingPathComponent(FacesState.fileName), options: [.atomicWrite, .completeFileProtection])
        } catch {
            fatalError(error.localizedDescription)
        }
        
    }
}
