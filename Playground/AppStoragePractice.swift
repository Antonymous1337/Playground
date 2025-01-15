//
//  AppStoragePractice.swift
//  Playground
//
//  Created by Antony Holshouser on 1/14/25.
//

import SwiftUI

struct AppStoragePractice: View {
    @AppStorage("name") private var count = 0
    
    var body: some View {
        VStack {
            Text(String(count))
            Button {
                count += 1
            } label: {
                Text("Increment")
            }
        }
    }
}

#Preview {
    AppStoragePractice()
}
