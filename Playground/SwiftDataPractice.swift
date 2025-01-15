

import SwiftUI
import SwiftData

struct SwiftDataPractice: View {
    @Environment(\.modelContext) private var context
    @Query var parents: [Parent]
    
    var body: some View {
        SwiftDataPracticeHelper(parents: parents)
    }
}

struct SwiftDataPracticeHelper: View {
    @Environment(\.modelContext) private var context
    var parents: [Parent]
    
    var body: some View {
        VStack {
            List {
                ForEach(parents, id: \.self) { parent in
                    VStack {
                        Text(parent.name)
                        List {
                            
                            ForEach(parent.children, id: \.self) { child in
                                Text("\t\(child.name)")
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) {
                                            context.delete(child)
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                    }
                                    .swipeActions(edge: .leading) {
                                        Button {
                                            child.name = UUID().uuidString
                                        } label: {
                                            Image(systemName: "heart")
                                        }
                                    }
                                
                            }
                        }
                        .frame(height: 400)
                        .listStyle(.plain)
                    }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                context.delete(parent)
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                let c = Child(name: "Child \(parent.children.count+1)")
                                parent.children.append(c)
//                                context.insert(c)
//                                do {
//                                    try context.save()
//                                } catch {
//                                    print(error.localizedDescription)
//                                }
                            } label: {
                                Image(systemName: "plus")
                            }
                            .tint(.blue)
                        }
                }
                
            }
            .listStyle(.plain)
            
            Button {
                do {
                    let p = Parent(name: "Parent \(parents.count+1)")
                    context.insert(p)
                    try context.save()
                } catch {
                    print("Save Error")
                }
            } label: {
                Text("Add Parent")
            }
        }
    }
}

@Model
final class Parent {
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \Child.parent)
    var children: [Child]
    
    init(name: String) {
        self.name = name
        self.children = [Child]()
    }
}

@Model
final class Child {
    var name: String
    
    @Relationship
    var parent: Parent?
    
    init(name: String) {
        self.name = name
    }
}

#Preview {
    SwiftDataPractice()
        .modelContainer(for: [Parent.self, Child.self], inMemory: true)
}
