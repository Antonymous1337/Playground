//
//  DarkModeDemo.swift
//  Playground
//
//  Created by Antony Holshouser on 3/12/25.
//

import SwiftUI

struct DarkModeDemo: View {
    var body: some View {
        VStack {
            
            VStack(spacing: 16) {
                Text("\"To be or not to be, that is the question my dear friend. I'm blue, daboodebadobaa\"")
                
                HStack {
                    Spacer()
                    Text("- Voldemort Sky Walker")
                }
                    
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(
                        colors: [.white.opacity(0.1), .white.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
            }
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke()
                    .fill(.white.opacity(0.3))
                    
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    DarkModeDemo()
        .preferredColorScheme(.dark)
}
