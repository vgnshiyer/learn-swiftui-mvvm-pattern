//
//  SearchScreen.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
//

import SwiftUI

struct SearchScreen: View {
    
    @State private var text: String = ""
    
    var body: some View {
        NavigationStack {
            Text("Show search here")
                .searchable(text: $text)
        }
    }
}

#Preview {
    SearchScreen()
}
