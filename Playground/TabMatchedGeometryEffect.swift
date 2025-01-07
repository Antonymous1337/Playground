//
//  TabMatchedGeometryEffect.swift
//  Playground
//
//  Created by Antony Holshouser on 1/7/25.
//

import SwiftUI

struct TabMatchedGeometryEffect: View {
    
    enum TabSelection: String {
        case first = "first"
        case second = "second"
        case third = "third"
    }
    
    @State var selectedTab: TabSelection = .first
    
    @Namespace private var namespace
    
    var body: some View {
        ZStack {
            
            switch selectedTab {
            case .first:
                Color.red.opacity(0.2)
                    .ignoresSafeArea()
            case .second:
                Color.blue.opacity(0.2)
                    .ignoresSafeArea()
            case .third:
                Color.green.opacity(0.2)
                    .ignoresSafeArea()
            }
            
        }
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 0) {
                Text("First")
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        withAnimation {
                            selectedTab = .first
                        }
                    }
                    .padding()
                    .background {
                        if selectedTab == .first {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    LinearGradient(colors: [Color.red.opacity(0.25), Color.red.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .matchedGeometryEffect(id: "tabBackground", in: namespace)
                        }
                    }
                
                
                Text("Second")
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        withAnimation {
                            selectedTab = .second
                        }
                    }
                    .padding()
                    .background {
                        if selectedTab == .second {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    LinearGradient(colors: [Color.blue.opacity(0.25), Color.blue.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .matchedGeometryEffect(id: "tabBackground", in: namespace)
                        }
                    }
                
                Text("Third")
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        withAnimation {
                            selectedTab = .third
                        }
                    }
                    .padding()
                    .background {
                        if selectedTab == .third {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    LinearGradient(colors: [Color.green.opacity(0.25), Color.green.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .matchedGeometryEffect(id: "tabBackground", in: namespace)
                        }
                    }
            }
            .padding(8)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .shadow(radius: 12, x: 4, y: 4)
            }
            .padding(.horizontal)
            .padding(.top)
            
        }
    }
}

#Preview {
    TabMatchedGeometryEffect()
}
