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
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    // How widget looks like, RIGHT NOW. Can be useful for when the user is trying to choose the app widget for them, USE USER DATA! Can be tricky when API or Network calls are necessary
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        
        // "entries" are another word for widget data
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        // 5 hours of date data up front per query
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
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
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

// The actual view that the user sees
struct Widget_PracticeEntryView : View {
    
    // The data passed into the view
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Favorite Emoji:")
            Text(entry.configuration.favoriteEmoji)
            
            Text("Test:")
            Text(String(entry.configuration.test))
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
        .configurationDisplayName("Display Name in Bold Text!")
        .description("Smaller, more subtle display text for extra user information")
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

#Preview(as: .systemSmall) {
    Widget_Practice()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
