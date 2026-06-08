//
//  HomeView.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 31/05/26.
//

import SwiftUI

struct HomeView: View {

    let completedItems: [(image: String, date: String, note: String?)] = [
        ("photo1", "2/6/26", "Very cute! AAAAAAA"),
        ("photo2", "2/6/26", nil),
        ("photo3", "1/6/26", "Great ride!"),
    ]

    let upcomingItems:
        [(icon: String, name: String, date: String, time: String)] = [
            ("figure.run", "Run at Jerman Beach", "15 May", "17:00 - 19:00"),
            ("figure.run", "Run at Jerman Beach", "15 May", "17:00 - 19:00"),
            ("figure.run", "Run at Jerman Beach", "16 May", "17:00 - 19:00"),
        ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    Image(.mascotProfile)
                        .resizable()
                        .frame(width: 92, height: 92)
                        .clipShape(Circle())

                    StatsRowView()

                    TodayEventCardView()
                    
                    // Tab (completed/upcoming)
                    // if scrolled down, and this component reach top, it sticks on top with the navtitle
                    ZStack {
                        HStack {
                            Text("Completed")
                                .foregroundStyle(Color.TGprimary.opacity(0.5))
                                .frame(maxWidth: .infinity)
                            Text("Upcoming")
                                .foregroundStyle(Color.TGprimary.opacity(0.5))
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.vertical, 10)
                        .background(Color.backgroundSecondary)
                        .clipShape(Capsule())
                        HStack (spacing: 0) {
                            Text("Completed") // if selected
                                .font(.labelL)
                                .foregroundStyle(Color.TGterniary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 7)
                                .background(Color.TGprimary)
                                .clipShape(Capsule())
                            Text("Upcoming") // if selected
                                .font(.labelL)
                                .foregroundStyle(Color.TGterniary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 7)
                                .background(Color.TGprimary)
                                .clipShape(Capsule())
                        }
                        .padding(.horizontal, 5)
                    }
                    // Tab Content
                    
                }
                .padding(.horizontal)
            }
            .background(Color.backgroundPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Hans Hartowidjojo")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.TGprimary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Menu action
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.TGprimary)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var profileHeader: some View {
        ZStack {
            Circle()
                .fill(Color.TGterniary)
                .frame(width: 88, height: 88)

            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 88, height: 88)
                .foregroundColor(.TGprimary)
        }
    }

    private var completedListView: some View {
        VStack(spacing: 12) {
            ForEach(completedItems.indices, id: \.self) { i in
                let item = completedItems[i]
                CompletedEventCardView(
                    sportIcon: "figure.outdoor.cycle",
                    date: item.date,
                    caption: item.note
                )
                .frame(height: 160)
                .padding(.horizontal, 16)
            }
        }
    }

    private var upcomingListView: some View {
        VStack(spacing: 10) {
            ForEach(upcomingItems.indices, id: \.self) { i in
                let item = upcomingItems[i]
                UpcomingEventCardView(
                    sportIcon: item.icon,
                    eventName: item.name,
                    date: item.date,
                    timeRange: item.time
                )
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    HomeView()
}
