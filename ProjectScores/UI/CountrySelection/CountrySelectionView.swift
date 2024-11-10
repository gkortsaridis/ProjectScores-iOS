//
//  CountrySelectionView.swift
//  ProjectScores
//
//  Created by George Kortsaridis on 10/11/2024.
//

import SwiftUI

struct CountrySelectionView: View {
	@StateObject private var viewModel = CountrySelectionViewModel()
	
	var body: some View {
		
		ScrollView {
					LazyVStack(alignment: .leading, spacing: 10) {
						if let countries = viewModel.countriesResponse?.response {
							ForEach(countries, id: \.id) { country in
								HStack {
									if let flagUrl = country.flag, let url = URL(string: flagUrl) {
										AsyncImage(url: url) { image in
											image.resizable()
												 .frame(width: 40, height: 24)
												 .clipShape(RoundedRectangle(cornerRadius: 4))
										} placeholder: {
											ProgressView()
										}
									} else {
										Rectangle()
											.fill(Color.gray)
											.frame(width: 40, height: 24)
									}
									
									Text(country.name)
										.font(.headline)
										.foregroundColor(.primary)
								}
								.padding(.horizontal)
							}
						} else {
							Text("Loading countries...")
								.padding()
						}
					}
				}
		
	}
}

#Preview {
    CountrySelectionView()
}
