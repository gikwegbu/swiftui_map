//
//  LocationCardView.swift
//  swiftui_map
//
//  Created by gikwegbu on 04/08/2024.
//

import SwiftUI

struct LocationCardView: View {
	let loc: LocationModel
	@EnvironmentObject private var vm: LocationsViewModel
	
	
    var body: some View {
			HStack(alignment: .bottom, spacing: 0) {
				VStack(alignment: .leading, spacing: 16) {
					imageSection
					titleSection
				}
				
				VStack(spacing: 8) {
					learnMore
					nextBtn
				}
			}
			.padding(20)
			.background(
				RoundedRectangle(cornerRadius: 10)
					.fill(.ultraThinMaterial)
					.offset(y: 65)
			)
//			.clipped()
			.cornerRadius(10)
    }
}

#Preview {
	LocationCardView(loc: LocationsDataService.locations.first!)
		.padding(10)
		.environmentObject(LocationsViewModel())
		
}



extension LocationCardView {
	private var imageSection: some View {
		ZStack {
			if let imageName = loc.imageNames.first {
				Image(imageName)
					.resizable()
					.scaledToFill()
					.frame(width: 100, height: 100)
					.cornerRadius(10)
				}
		}
		.padding(6)
		.background(Color.white)
		.cornerRadius(10)
	}
	
	private var titleSection: some View {
		VStack(alignment: .leading, spacing: 4) {
			Text(loc.name)
				.font(.title2)
				.fontWeight(.bold)
			
			Text(loc.cityName)
				.font(.subheadline)
		}
		.frame(maxWidth: .infinity, alignment: .leading)
	}
	
	private var learnMore: some View {
		Button {
			vm.updateCurrentLocationSheet(loc: loc)
		} label: {
			Text("Learn more")
				.font(.headline)
				.frame(width: 125, height: 35)
		}
		.buttonStyle(.borderedProminent)
	}
	
	private var nextBtn: some View {
		Button {
			vm.nextBtnPress()
		} label: {
			Text("Next")
				.font(.headline)
				.frame(width: 125, height: 35)
		}
		.buttonStyle(.bordered)
	}
}
