//
//  LocationsView.swift
//  RickAndMorty
//
//  Created by Yery Castro on 31/3/24.
//

import SwiftUI

struct LocationsProfileView: View {
    @ObservedObject var vm2: LocationVM
    let location: Locations
    var body: some View {
        
        let residentString = location.residents
                            .compactMap { URL(string: $0)?.lastPathComponent }
                            .joined(separator: ", ")
        
        
        Form {
                LocationsCellView(vm2: .preview, title: "ID", label: "\(location.id)")
                LocationsCellView(vm2: .preview, title: "Type", label: location.type)
                LocationsCellView(vm2: .preview, title: "Name", label: location.name)
                LocationsCellView(vm2: .preview, title: "Dimension", label: location.dimension)
                LocationsCellView(vm2: .preview, title: "Residents", label: residentString)
                LocationsCellView(vm2: .preview, title: "Url", label: location.url)
                LocationsCellView(vm2: .preview, title: "Created", label: location.created)
            }
        }
    }


#Preview {
        LocationsProfileView(vm2: .preview, location: .preview)
            .environmentObject(LocationVM.preview)
}

