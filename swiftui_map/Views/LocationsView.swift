//
//  LocationsView.swift
//  swiftui_map
//
//  Created by gikwegbu on 03/08/2024.
//

import SwiftUI


struct LocationsView: View {
	@EnvironmentObject  var vm: LocationsViewModel
	@State private var showDetails: Bool = false
	var body: some View {
		ZStack {
			mapView
				.ignoresSafeArea()
			VStack {
				locationsViewHeader
					.frame(maxWidth: 700)
				Spacer()
				currentMapLocationCard
			}
		}
		.sheet(item: $vm.currentLocationSheet, onDismiss: nil) { loc in
			SingleLocationDetailsView(loc: loc)
		}
	}
	
	
}

#Preview {
	LocationsView()
		.environmentObject(LocationsViewModel())
}
