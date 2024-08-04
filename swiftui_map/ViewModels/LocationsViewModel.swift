//
//  LocationsViewModel.swift
//  swiftui_map
//
//  Created by gikwegbu on 03/08/2024.
//
import SwiftUI
import Foundation
import MapKit


class LocationsViewModel: ObservableObject {
	@Published var locations: [LocationModel]
	@Published var mapLocation: LocationModel {
		didSet {
			updateMapRegion(loc: mapLocation)
		}
	}
	@Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
	let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
	
	@Published var showLocationsList: Bool = false
	@Published var currentLocationSheet: LocationModel? = nil
	
	init() {
		let locations = LocationsDataService.locations
		self.locations = locations
		self.mapLocation = locations.first!
		self.updateMapRegion(loc: locations.first!)
	}
	
	
	func updateMapLocation(loc: LocationModel) {
		withAnimation(.easeInOut) {
			mapLocation = loc
			showLocationsList = false
		}
	}
	
	private func updateMapRegion(loc: LocationModel) {
		withAnimation(.easeInOut) {
			mapRegion = MKCoordinateRegion(center: loc.coordinates, span: mapSpan)
		}
	}
	
	func toggleLocationsList() {
		withAnimation(.easeInOut) {
			showLocationsList.toggle()
		}
	}
	
	func nextBtnPress() {
		// Find the index of the current MapLocation
//		let currenIndex = locations.firstIndex { loc in
//			return loc == mapLocation
//		}
		
		guard	let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
			return
		}
		
		// Now check if the next index is valid:
		let nextIndex = currentIndex + 1
		guard locations.indices.contains(nextIndex) else {
			// i.e if the next index is not available, we default to the first item.
			updateMapLocation(loc:locations.first!)
			return
		}
		updateMapLocation(loc:locations[nextIndex])
	}
	
	func updateCurrentLocationSheet(loc: LocationModel) {
		currentLocationSheet = loc
	}
}
