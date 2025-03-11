//
//  LongPressDemo.swift
//  Playground
//
//  Created by Antony Holshouser on 2/21/25.
//

import SwiftUI

struct LongPressDemo: View {
    var body: some View {
        VStack {
            Menu {
                Button {
                    print("Action 1")
                } label: {
                    Label("Add to Reading List", systemImage: "eyeglasses")
                }
                Button {
                    print("Action 2")
                } label: {
                    Label("Add Bookmarks for All Tabs", systemImage: "book")
                }
                Button {
                    print("Action 3")
                } label: {
                    Label("Show All Bookmarks", systemImage: "books.vertical")
                }
            } label: {
                Label("Add Bookmark", systemImage: "book")
            } primaryAction: {
                print("Primary")
            }
            .menuStyle(.button)
            .buttonStyle(.plain)
            
            Text("On long press")
                .contextMenu {
                    Menu {
                        Button {
                            print("Action 1")
                        } label: {
                            Label("Add to Reading List", systemImage: "eyeglasses")
                        }
                        Button {
                            print("Action 2")
                        } label: {
                            Label("Add Bookmarks for All Tabs", systemImage: "book")
                        }
                        Button {
                            print("Action 3")
                        } label: {
                            Label("Show All Bookmarks", systemImage: "books.vertical")
                        }
                    } label: {
                        Label("Add Bookmark", systemImage: "book")
                    } primaryAction: {
                        print("Primary")
                    }
                }
            Menu("On tap") {
                menuItems
            }
        }
    }
    
    var menuItems: some View {
        Group {
            Button("Action 1", action: {})
            Button("Action 2", action: {})
            Button("Action 3", action: {})
        }
    }
}

#Preview {
    LongPressDemo()
}
