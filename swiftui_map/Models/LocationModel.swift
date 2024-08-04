//
//  LocationModel.swift
//  swiftui_map
//
//  Created by gikwegbu on 03/08/2024.
//

import Foundation
import MapKit


// We need this model to conform to equatable, so that
// No twoo data can be same.. sorta a hash thingy...

struct LocationModel: Identifiable, Equatable {
	
	
	let name: String
	let cityName: String
	let coordinates: CLLocationCoordinate2D
	let description: String
	let imageNames: [String]
	let link: String
	
	var id: String {
		return name + cityName
	}
	
	static func == (lhs: LocationModel, rhs: LocationModel) -> Bool {
		// lhs: left hand side
		// rhs: right hand side
		lhs.id == rhs.id
	}
}
