//
//  ContentView.swift
//  Playground
//
//  Created by Antony Holshouser on 1/2/25.
//

import SwiftUI

struct CircularKnob: View {
    
    @State var centerx: CGFloat = 0
    @State var centery: CGFloat = 0
    
    let circleWidth: CGFloat = 250
    
    @State var isDragging = false
    
    @State var tempAngleOffset: Angle = Angle(degrees: 0)
    @State var angleOffset: Angle = Angle(degrees: 0)
    
    @State var momentum = Angle(degrees: 0)
    
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            
            
            ZStack {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 50))
                
                AngularGradient(colors: [.orange, .purple, .green, .red, .blue, .pink, .brown, .yellow], center: .center, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360))
                    .mask {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 30, lineCap: .butt, dash: [14]))
                    }
            }
            .background {
                GeometryReader { proxy in
                    Circle()
                        .fill(.clear)
                        .onAppear {
                            centerx = proxy.frame(in: .global).midX
                            centery = proxy.frame(in: .global).midY
                        }
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged { value in
                        isDragging = true
                        
                        momentum = Angle(degrees: 0)
                        
                        tempAngleOffset = Angle(radians: atan2(value.location.y - centery, value.location.x - centerx)) - Angle(radians: atan2(value.startLocation.y - centery, value.startLocation.x - centerx))
                    }
                    .onEnded { value in
                        isDragging = false
                        angleOffset += tempAngleOffset
                        tempAngleOffset = Angle(degrees: 0)
                        
                        
                    }
            )
            .rotationEffect(tempAngleOffset, anchor: .center)
            .rotationEffect(angleOffset, anchor: .center)
            
            
            
        }
        .frame(width: circleWidth)
        
        Text(String(momentum.degrees))
        Text(String(angleOffset.degrees))
        Text(String(tempAngleOffset.degrees))
    }
}

#Preview {
    CircularKnob()
}
