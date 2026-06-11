////
////  CustomTipCard.swift
////  2Gather
////
////  Created by RyanMFDR on 11/06/26.
////
//import SwiftUI
//
//struct CustomTipCardView: View {
//    let message: String
//    let onNext: () -> Void
//    let onSkip: () -> Void
//    var nextLabel: String = "Next"
//
//    var body: some View {
//        ZStack(alignment: .topTrailing) {
//            Color.black.opacity(0.75)
//                .ignoresSafeArea()
//
//            Button("Skip", action: onSkip)
//                .font(.system(size: 15))
//                .foregroundColor(.white.opacity(0.55))
//                .padding(.top, 60)
//                .padding(.trailing, 20)
//
//            VStack {
//                Spacer()
//                HStack(alignment: .bottom, spacing: 0) {
//                    mascotBubble
//                    Spacer()
//                }
//                .padding(.horizontal, 20)
//                .padding(.bottom, 110)
//            }
//        }
//        .transition(.opacity)
//    }
//
//    private var mascotBubble: some View {
//        ZStack(alignment: .bottomLeading) {
//            VStack(alignment: .leading, spacing: 16) {
//                Text(message)
//                    .font(.system(size: 16, weight: .medium))
//                    .foregroundColor(.TGprimary)
//                    .multilineTextAlignment(.leading)
//                    .fixedSize(horizontal: false, vertical: true)
//
//                HStack {
//                    Spacer()
//                    Button(nextLabel, action: onNext)
//                        .font(.system(size: 15, weight: .semibold))
//                        .foregroundColor(.TGterniary)
//                        .padding(.horizontal, 24)
//                        .padding(.vertical, 10)
//                        .background(Color.TGsecondary)
//                        .clipShape(Capsule())
//                }
//            }
//            .padding(20)
//            .background(Color.red aa a)
//            .clipShape(RoundedRectangle(cornerRadius: 22))
//            .padding(.leading, 50)
//
//            // Mascot
//            ZStack {
//                Circle()
//                    .fill(.white)
//                    .frame(width: 76, height: 76)
//                Image(.mascotTutorial)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 90, height: 90)
//                    .offset(x: -20)
//            }
//            .offset(y: 8)
//            .overlay(
//                Circle()
//                    .stroke(Color.TGterniary, lineWidth: 3)
//                    .frame(width: 76, height: 76)
//                    .offset(y: 8)
//            )
//        }
//    }
//}
//
//#Preview {
//    CustomTipCardView(
//        message: "Hi, I'm TwoGe! I'm here to guide you on how to navigate 2Gather.",
//        onNext: {},
//        onSkip: {}
//    )
//}
