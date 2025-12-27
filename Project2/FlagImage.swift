//
//  FlagImage.swift
//  Project2
//
//  Created by Peter Gabriel on 27.12.25.
//

import SwiftUI


struct FlagImage: View {
    let name: String
    
    var body: some View {
        Image(name)
            .clipShape(.rect)
            .shadow(radius: 5)
    }
}

#Preview {
    FlagImage(name: "France")
}
