//
//  SingleLocationDetailsView.swift
//  swiftui_map
//
//  Created by gikwegbu on 04/08/2024.
//

import SwiftUI
import MapKit

struct SingleLocationDetailsView: View {
	@EnvironmentObject private var vm: LocationsViewModel
	@Environment(\.dismiss) private var dismiss
	let loc: LocationModel
	
    var body: some View {
			ScrollView{
				VStack {
					imageSection
					
					VStack(alignment: .leading, spacing: 16) {
						titleAndSubtitleSection
						Divider()
						descriptionSection
						Divider()
						mapLayerView
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding()
				}
			}
			.ignoresSafeArea()
			.background(.ultraThinMaterial)
			.overlay(
				backBtn,
				alignment: .topLeading
			)
    }
}

#Preview {
	SingleLocationDetailsView(loc: LocationsDataService.locations.first!)
		.environmentObject(LocationsViewModel())
}


extension SingleLocationDetailsView {
	private var imageSection: some View {
		TabView {
			ForEach(loc.imageNames, id: \.self) {
				Image($0)
					.resizable()
					.scaledToFill()
//					.frame(width: UIScreen.main.bounds.width)
				// Adjusting the image for IPAD
					.frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
					.clipped()
				// The above, frame and clipped, helped remove a wobly image loading effect..
			}
		}
		.frame(height: 500)
		.tabViewStyle(PageTabViewStyle())
		.shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
	}
	
	private var titleAndSubtitleSection: some View {
		VStack(alignment: .leading, spacing: 8){
			Text(loc.name)
				.font(.largeTitle)
				.fontWeight(.semibold)
			
			Text(loc.cityName)
				.font(.title3)
				.foregroundStyle(.secondary)
		}
	}
	
	private var descriptionSection: some View {
		VStack(alignment: .leading, spacing: 16){
			Text(loc.description)
				.font(.subheadline)
				.foregroundStyle(.gray)
			
			if let url = URL(string: loc.link) {
//				Link("Read more on Wikipedia", destination: url)
				let link = "[Read more on Wikipedia](\(url))"
				Text(.init(link))
					.font(.headline)
					.tint(.blue)
			}
		}
	}
	
	var mapLayerView: some View {
		Map(
			// Because, this particular is not moving, it's static, hence us using .contant
			coordinateRegion: .constant(
				MKCoordinateRegion(
					center: loc.coordinates,
					span: MKCoordinateSpan(
//						latitudeDelta: 0.001,
//						longitudeDelta: 0.005
						latitudeDelta: 0.01,
						longitudeDelta: 0.01
					)
				)
			),
			// Since it's just one item we are interested in
			annotationItems: [loc]) {loc in
				MapAnnotation(coordinate: loc.coordinates) {
					CustomLocationPin()
						.shadow(radius: 10)
				}
			}
			.allowsHitTesting(false) // this disables the dragging ability of the map
			.aspectRatio(1, contentMode: .fit)
			.cornerRadius(30)
	}
	
	private var backBtn: some View {
		Button(action: {
//			dismiss()
			vm.currentLocationSheet = nil // this will dismiss the sheet automatically
		}, label: {
			Image(systemName: "xmark")
				.font(.headline)
				.padding(16)
				.foregroundStyle(.primary)
				.background(.ultraThinMaterial)
				.cornerRadius(10)
				.shadow(radius: 4)
				.padding()
		})
	}
}
