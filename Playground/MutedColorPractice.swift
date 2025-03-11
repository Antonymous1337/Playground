//
//  MutedColorPractice.swift
//  Playground
//
//  Created by Antony Holshouser on 1/23/25.
//

import SwiftUI

struct MutedColorPractice: View {
    var body: some View {
        ZStack {
            Text("Hello, World")
                .frame(maxWidth: .infinity)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 25.0)
                }
                .padding()
        }
    }
}

#Preview {
        MutedColorPractice()
    
}
