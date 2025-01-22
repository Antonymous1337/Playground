//
//  ContainerPractice.swift
//  Playground
//
//  Created by Antony Holshouser on 1/21/25.
//

import SwiftUI

struct ContainerPractice: View {
    @State var showText = false
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring(duration: 0.2)) {
                        showText.toggle()
                    }
                }
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .ignoresSafeArea()
                    .containerRelativeFrame(.vertical) { height, _ in
                        height/2
                    }
            }
            .containerRelativeFrame(.vertical, count: 1, span: showText ? 1 : 3, spacing: 0.0, alignment: .bottom)
        }
        
    }
}

#Preview {
    ContainerPractice()
}
