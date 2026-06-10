//
//  EventDetailSheet.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftData
import SwiftUI

struct EventDetailSheet: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query private var userStates: [UserEventState]

    var event: Event
    @State private var viewModel: EventDetailViewModel
    
    @State private var showFullScreenView = false

    init(event: Event) {
        self.event = event
        _viewModel = State(
            initialValue: EventDetailViewModel(mission: event.mission)
        )
    }

    private var currentUserState: UserEventState? {
        userStates.first(where: { $0.eventId == event.id })
    }

    private var isJoined: Bool {
        currentUserState != nil
    }
    
    private var isCompleted: Bool {
        currentUserState?.isCompleted == true
    }
    
    private var sport: SportCategory {
        SportCategory.from(categories: event.category)
    }

    var body: some View {
        
        NavigationStack {
           
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {

                        VStack(alignment: .leading, spacing: 16) {

                            HStack (alignment: .center) {
                                Text(event.name)
                                    .foregroundStyle(Color.TGBrownToWhite)
                                    .font(.headingL)
                                    .bold()
                                
                                Spacer()
                                HStack (spacing: 10) {
                                    Button {
                                        Void()
                                    } label: {
                                        Image(systemName: "square.and.arrow.up")
                                    }
                                        .frame(width: 44, height: 44)
                                        .background(Circle().fill(Color.gray.opacity(0.16)))
                                        .foregroundStyle(Color.TGBrownToWhite)
                                    
                                    
                                    Button {
                                        dismiss()
                                    } label: {
                                        Image(systemName: "xmark")
                                    }.buttonStyle(.plain)
                                        .frame(width: 44, height: 44)
                                        .background(Circle().fill(Color.gray.opacity(0.16)))
                                        .foregroundStyle(Color.TGBrownToWhite)
                                }
                            }
                            

                            EventInfoRowView(event: event)
                                .padding(.top, 8)

                            MissionSectionView(
                                mission: $viewModel.mission,
                                eventId: event.id,
                                isJoined: isJoined,
                                onJoin: {
                                    let newState = UserEventState(eventId: event.id)
                                    modelContext.insert(newState)
                                    
                                    showFullScreenView = true
                                },
                                onMissionComplete: { message in
                                    if let state = currentUserState {
                                        state.isCompleted = true
                                    }
                                    viewModel.rewardMessage = message
                                    viewModel.showReward = true
                                }
                            )
                            
                            if isJoined && !isCompleted {
                                HStack {
                                    Spacer()
                                    Button("Cancel event"){
                                        if let state = currentUserState {
                                            modelContext.delete(state)
                                            dismiss()
                                        }
                                    }.foregroundStyle(Color.TGRedToOrange)
                                    Spacer()
                                }
                            }
                                
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 31)
                        .padding(.bottom, 44)
                    }
                }

            }
            .animation(.spring(duration: 0.3), value: viewModel.showReward)
            .presentationDetents([.medium])
            .fullScreenCover(isPresented: $viewModel.showReward) {
                CompletedMissionBannerView(
                    onDismiss: { viewModel.showReward = false },
                    eventName: event.name,
                    sport: sport
                )
                .transition(.scale.combined(with: .opacity))
            }
            .fullScreenCover(isPresented: $showFullScreenView) {
                MissionBannerFullScreenView(mission: $viewModel.mission, event: event)
            }
        }
        
    }
}

#Preview {
    EventDetailSheet(event: TempData.event1 )
}
