//
//  LocationListRowViewExtension.swift
//  swiftui_map
//
//  Created by gikwegbu on 03/08/2024.
//

import SwiftUI


extension LocationListView {
	
	// Because this extention is a function, we need to return the view, and to do that, we'd return some View
	func locationListRowView(loc: LocationModel) -> some View {
		HStack{
			if let imageName = loc.imageNames.first {
				Image(imageName)
					.resizable()
					.scaledToFill()
					.frame(width: 45, height: 45)
					.cornerRadius(10) 
			}
			
			VStack(alignment: .leading, content: {
				Text(loc.name)
					.font(.headline)
				Text(loc.cityName)
					.font(.subheadline)
				
			})
			.frame(maxWidth: .infinity, alignment: .leading)
			
		}
	}
}
