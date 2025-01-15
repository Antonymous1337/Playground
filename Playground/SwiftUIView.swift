//
//  SwiftUIView.swift
//  Playground
//
//  Created by Antony Holshouser on 1/7/25.
//

import SwiftUI

struct SwiftUIView: View {
    @State var colorIndex = 0
    let textColors = [
        Color.blue,
        Color.pink
    ]
    
    var body: some View {
        VStack {
            Text("You")
            Text("+")
            Text("Me")
            Text("=")
            Image(systemName: colorIndex == 0 ? "heart" : "heart.fill")
        }
        .font(.largeTitle)
        .foregroundStyle(textColors[colorIndex])
        .scaleEffect(colorIndex == 0 ? 1.0 : 1.1)
        .task {
            while true {
                DispatchQueue.main.async {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        colorIndex = (colorIndex+1)%textColors.count
                    }
                }
                print(colorIndex)
                do {
                    try await Task.sleep(for: .seconds(1.0))
                } catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
