//
//  LocationsView.swift
//  RickAndMorty
//
//  Created by Yery Castro on 1/4/24.
//

import SwiftUI

struct LocationsView: View {
    @ObservedObject  var vm2: LocationVM
    @State private var selectedLocation: Locations?
    
    let location: Locations
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm2.locations, id: \.self) { location in
                    LocationsCellView( vm2: .preview, title: location.type, label: location.name)
                        .onTapGesture {
                            self.selectedLocation = location
                            
                        }
                        .sheet(item: $selectedLocation) { location in
                            LocationsProfileView( vm2: .preview, location: location)
                        }
                        
                        
                }
            }
            .navigationTitle("Locations")
        }
    }
}

#Preview {
    NavigationStack {
        LocationsView(vm2: .preview, location: .preview)
            .environmentObject(LocationVM.preview)
    }
}
