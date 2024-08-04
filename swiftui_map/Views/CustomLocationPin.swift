//
//  CustomLocationPin.swift
//  swiftui_map
//
//  Created by gikwegbu on 04/08/2024.
//

import SwiftUI

struct CustomLocationPin: View {
	
	let accentColor = Color("AccentColor")
	
    var body: some View {
			VStack(spacing: 0) {
				Image(systemName: "map.circle.fill")
					.resizable()
					.scaledToFit()
					.frame(width: 30, height: 30)
					.foregroundStyle(.white)
					.padding(6)
					.background(accentColor)
					.cornerRadius(36)
				
				Image(systemName: "triangle.fill")
					.resizable()
					.scaledToFit()
					.foregroundStyle(accentColor)
					.frame(width: 10, height: 10)
					.rotationEffect(Angle(degrees: 180))
					.offset(y: -2)
			}
			// This offset will help place the marker directly ontop of the location on our map...
			.offset(y: -28)
    }
}

#Preview {
    CustomLocationPin()
}
