//
//  Widget_Practice.swift
//  Widget Practice
//
//  Created by Antony Holshouser on 1/16/25.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    
     // when there is no data, how will it look like
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    // How widget looks like, RIGHT NOW. Can be useful for when the user is trying to choose the app widget for them, USE USER DATA! Can be tricky when API or Network calls are necessary
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> DayEntry {
        DayEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<DayEntry> {
        
        // "entries" are another word for widget data
        var entries: [DayEntry] = []

        // Generate a timeline consisting of 7 entries an day apart, starting from the current date.
        let currentDate = Date()
        // 7 days of date data up front per query
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startDate = Calendar.current.startOfDay(for: entryDate) // make sure updates happen at the START of the day, when midnight strikes
            let entry = DayEntry(date: startDate, configuration: configuration)
            entries.append(entry)
        }

        // Policies:
        // .atEnd means whenever it ends, reload the data again
        // .after(Date) means update at a specific date, like on midnight
        // .never is used to update ONLY on user input, such as streaks information (for example), or like the notes app
        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

// Data that populates the widget
struct DayEntry: TimelineEntry {
    let date: Date // Date is manditory? It is used to know when to update the view with pre-entered entry data
    let configuration: ConfigurationAppIntent
}

// The actual view that the user sees
struct Widget_PracticeEntryView : View {
    
    // The data passed into the view
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(.red.gradient)
            
            VStack {
                HStack(spacing: 4) {
                    Text("⛄️")
                        .font(.title)
                    Text(entry.date.formatted(.dateTime.weekday(.wide)))
                        .font(.title3)
                }
                .minimumScaleFactor(0.001)
                .lineLimit(1)
                
                
                Text(entry.date.formatted(.dateTime.day()))
                    .font(Font.system(size: 500))
                    .minimumScaleFactor(0.001)
                    .bold()
            }
            .padding()
        }
    }
}

struct Widget_Practice: Widget {
    let kind: String = "Widget_Practice"

    // Two types of configurations:
    // Static configurations are updated by app and can't be updated by user
    // Intent configurations are INTENTionally configured by the user
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            Widget_PracticeEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .contentMarginsDisabled() // TO MAKE FULL SCREEN COLOR BACKGROUND, .ignoreSafeArea wont work
        .configurationDisplayName("Monthly Style Widget!")
        .description(Text("The theme of the widget changes based on the month! :D"))
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

// multiple previes sizes, .systemSmall to .systemExtraLarge
// Don't just scale up widgets to a bigger size for no reason. Add more info for bigger-sized widgets. This system size just affects the PREVIEW, not whats actually available for the user
#Preview(as: .systemSmall) {
    Widget_Practice()
} timeline: {
    // example entries to play around with in the preview
    DayEntry(date: .now, configuration: .smiley)
    DayEntry(date: .now, configuration: .starEyes)
}
