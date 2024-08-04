//
//  LocationViewsExtensions.swift
//  swiftui_map
//
//  Created by gikwegbu on 03/08/2024.
//

import SwiftUI
import MapKit

extension LocationsView {
	var locationsViewHeader: some View {
		VStack(spacing: 0) {
			VStack {
				Button {
					vm.toggleLocationsList()
				} label: {
					
					
					Text(vm.mapLocation.name + "," + vm.mapLocation.cityName)
						.font(.title2)
						.fontWeight(.black)
						.foregroundStyle(.primary)
						.frame(height: 55)
						.frame(maxWidth: .infinity)
					// Removing the animation on this Text
					// Check the LocationModel, for the Equatable Protocol
						.animation(.none, value: vm.mapLocation)
						.overlay(alignment: .leading){
							Image(systemName:  "arrow.down")
								.font(.headline)
								.foregroundStyle(.primary)
								.padding()
								.rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
						}
				}
				
				if vm.showLocationsList {
					LocationListView()
				}
			}
			.background(.thickMaterial)
			.cornerRadius(10)
			.shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
		}
		.padding()
	}
	
	var mapView: some View {
		Map(
			coordinateRegion: $vm.mapRegion,
			// RandomAccessCollection is just a Data, which is also used in a ForEach
			annotationItems: vm.locations,
			// The annotationContent, means, for each of the above annotationItems, what do we wanna put on the map, in this case, our pin...
			annotationContent: { loc in
				// This is the default design apple gives us..
				//					MapMarker(coordinate: loc.coordinates, tint: .blue)
				// Now making our custom pin/maker...
				MapAnnotation(coordinate: loc.coordinates) {
					//						Text("George...") // You can put anything here charlie
					CustomLocationPin()
						.scaleEffect(vm.mapLocation == loc ? 1 : 0.5)
						.shadow(radius: 10)
						.onTapGesture {
							vm.updateMapLocation(loc: loc)
						}
				}
			}
		)
	}
	
	var currentMapLocationCard: some View {
		ZStack{
			ForEach(vm.locations) { loc in
				if vm.mapLocation == loc {
					LocationCardView(loc: loc)
						.shadow(color: Color.black.opacity(0.3), radius: 20)
						.padding()
						.frame(maxWidth: 700) // This truncates the width fo Ipad
						.frame(maxWidth: .infinity) // This helps for the edge transition
						.transition(.asymmetric(
							insertion:.move(edge: .trailing),
							//									removal: .opacity)
							removal: .move(edge: .leading))
						)
				}
			}
		}
		.padding(.bottom, 10)
	}
}
