//
// Created by me
  

import Foundation
import UIKit
import MapKit

struct Face: Codable, Identifiable, Comparable {
    
    static func == (lhs: Face, rhs: Face) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: Face, rhs: Face) -> Bool {
        return lhs.name < rhs.name
    }

    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    var imageData: UIImage? {
        let file = File.getDocumentsDirectory().appendingPathComponent(id)
        guard File.fileExists(at: file.path), let data = try? Data(contentsOf: file) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    enum CodingKeys: CodingKey {
        case id, name, longitude, latitude
    }
    
    init(id: String, name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.id = id
        self.name = name
        self.coordinate = coordinate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        if container.contains(.longitude) && container.contains(.latitude) {
            let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
            let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
            coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            coordinate = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if let coordinate = coordinate {
            try container.encode(coordinate.latitude, forKey: .latitude)
            try container.encode(coordinate.longitude, forKey: .longitude)
        }
    }
    
}
