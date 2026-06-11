//
//  TwoGeTipKit.swift
//  2Gather
//
//  Created by RyanMFDR on 11/06/26.
//

import TipKit

// MARK: - User Action Events (for rule-based gating)
extension Tips {
    static let navigatedToExplore = Event(id: "navigatedToExplore")
    static let tappedAnEvent      = Event(id: "tappedAnEvent")
    static let joinedAnEvent      = Event(id: "joinedAnEvent")
    static let tookMissionPhoto   = Event(id: "tookMissionPhoto")
}

// MARK: - Step 1: HomeView welcome
struct WelcomeTip: Tip {
    var title: Text { Text("Welcome to 2Gather!") }
    var message: Text? { Text("Welcome message") }
}

// MARK: - Step 2: HomeView → prompt to explore
struct GoToExploreTip: Tip {
    var title: Text { Text("Explore Events") }
    var message: Text? { Text("Try to navigate into the Explore tab.") }

    var rules: [Rule] {
        [#Rule(Tips.navigatedToExplore) { $0.donations.count == 0 }]
    }
}

// MARK: - Step 3: MapView intro
struct MapWelcomeTip: Tip {
    var title: Text { Text("Find Nearby Events") }
    var message: Text? { Text("In this tab you can find nearby events based on the sport you love.") }

}

// MARK: - Step 4: MapView → prompt to tap an event
struct TapEventTip: Tip {
    var title: Text { Text("Join an Event") }
    var message: Text? { Text("Try joining an event — tap any event shown on the map.") }
}

// MARK: - Step 5: EventDetailSheet → prompt to join
struct JoinEventTip: Tip {
    var title: Text { Text("Register") }
    var message: Text? { Text("Click here to join and register for this event.") }

    var rules: [Rule] {
        [#Rule(Tips.tappedAnEvent) { $0.donations.count > 0 }]
    }
}

// MARK: - Step 6: EventDetailSheet → mission photo
struct MissionPhotoTip: Tip {
    var title: Text { Text("Today's Mission") }
    var message: Text? { Text("Look! Here's your mission for today. Quick, take a picture!") }

    var rules: [Rule] {
        [#Rule(Tips.joinedAnEvent) { $0.donations.count > 0 }]
    }
}

// MARK: - Step 8: MapView → go check home
struct CheckHomeTip: Tip {
    var title: Text { Text("Check Your Progress") }
    var message: Text? { Text("You can check your completed mission in the Home view.") }

    var rules: [Rule] {
        [#Rule(Tips.tookMissionPhoto) { $0.donations.count > 0 }]
    }
}     

// MARK: - Step 9: HomeView → sport preferences
struct SportPreferencesTip: Tip {
    var title: Text { Text("Your Preferences") }
    var message: Text? { Text("You can also change your sport preferences here.") }

    var rules: [Rule] {
        [#Rule(Tips.tookMissionPhoto) { $0.donations.count > 0 }]
    }
}
