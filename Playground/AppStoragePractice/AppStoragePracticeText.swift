//
//  AppStoragePracticeText.swift
//  Playground
//
//  Created by Antony Holshouser on 1/14/25.
//

import SwiftUI

struct AppStoragePracticeText: View {
    @AppStorage("name") private var count = 0
    
    var body: some View {
        Text(String(count))
    }
}

#Preview {
    AppStoragePracticeText()
}
