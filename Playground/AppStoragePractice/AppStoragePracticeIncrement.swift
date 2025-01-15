//
//  AppStoragePracticeIncrement.swift
//  Playground
//
//  Created by Antony Holshouser on 1/14/25.
//

import SwiftUI

struct AppStoragePracticeIncrement: View {
    @AppStorage("name") private var count = 0
    
    var body: some View {
        Button {
            count += 1
        } label: {
            Text("Increment")
        }
    }
}

#Preview {
    AppStoragePracticeIncrement()
}
