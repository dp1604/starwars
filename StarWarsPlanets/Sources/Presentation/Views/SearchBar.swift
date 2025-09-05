//
//  SearchBar.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onTextChanged: (String) -> Void

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)

            TextField("Search planets...", text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .onChange(of: text) { newValue in
                    onTextChanged(newValue)
                }

            if !text.isEmpty {
                Button(action: {
                    text = ""
                    onTextChanged("")
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
