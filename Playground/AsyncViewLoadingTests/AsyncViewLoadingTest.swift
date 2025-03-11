//
//  AsyncViewLoadingTest.swift
//  Playground
//
//  Created by Antony Holshouser on 3/10/25.
//

import SwiftUI

struct AsyncViewLoadingTest: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var second = 0
    
    @State private var background: AnyView?
    
    var body: some View {
        
        ZStack {
            
            if let uwBackground = background {
                uwBackground
            }
            
            Text("\(second)")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.gray)
            
        }
        .onReceive(timer) { _ in
            second += 1
        }
        .onAppear {
            DispatchQueue.global(qos: .background).async {
                let tempView = loadBackground()
                DispatchQueue.main.async {
                    background = tempView
                }
            }
        }
    }
    
    func loadBackground() -> AnyView {
        return AnyView(
            Grid(horizontalSpacing: 0.1, verticalSpacing: 0.1) {
                ForEach(0..<300, id: \.self) { _ in
                    GridRow {
                        ForEach(0..<300, id: \.self) { _ in
                            TestView()
                        }
                    }
                }
            }
            .ignoresSafeArea()
        )
        
    }
    
}

fileprivate struct TestView: View {
    var body: some View {
        Rectangle()
            
    }
}

#Preview {
    AsyncViewLoadingTest()
}
