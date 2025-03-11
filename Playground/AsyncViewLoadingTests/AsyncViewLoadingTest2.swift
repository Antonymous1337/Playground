//
//  AsyncViewLoadingTest.swift
//  Playground
//
//  Created by Antony Holshouser on 3/10/25.
//

import SwiftUI

struct AsyncViewLoadingTest2: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var second = 0
    
    @State private var backgroundRectangles = [[AnyView?]](repeating: [AnyView?](repeating: nil, count: 200), count: 200)
    
    let columnCount = 200
    let rowCount = 200
    
    var body: some View {
        
        ZStack {
            
            Grid(horizontalSpacing: 0.1, verticalSpacing: 0.1) {
                ForEach(0..<rowCount, id: \.self) { curRow in
                    GridRow {
                        ForEach(0..<columnCount, id: \.self) { curColumn in
                            if let curRectangle = backgroundRectangles[curRow][curColumn] {
                                curRectangle
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea()
            
            Text("\(second)")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.gray)
            
        }
        .onReceive(timer) { _ in
            second += 1
        }
        .task {
            await loadBackground()
        }
    }
    
    #warning("Have to think about how to load many views")
    func loadBackground() async {
        for curRow in 0..<rowCount {
            for curColumn in 0..<columnCount {
                
            }
        }
    }
    
}

fileprivate struct TestView: View {
    var body: some View {
        Rectangle()
            
    }
}

#Preview {
    AsyncViewLoadingTest2()
}
