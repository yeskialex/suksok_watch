//
//  ContentView.swift
//  Suksok Apple Watch Watch App
//
//  Created by Yehezkiel Alexander on 11/3/25.
//

import SwiftUI

// Data structures for complex pages
struct BackgroundElement: Identifiable {
    let id = UUID()
    let imageName: String
    let position: CGPoint
    let size: CGSize
    let opacity: Double

    init(imageName: String, position: CGPoint, size: CGSize = CGSize(width: 100, height: 100), opacity: Double = 1.0) {
        self.imageName = imageName
        self.position = position
        self.size = size
        self.opacity = opacity
    }
}

struct OverlayElement: Identifiable {
    let id = UUID()
    let imageName: String
    let position: CGPoint
    let size: CGSize
    let opacity: Double

    init(imageName: String, position: CGPoint, size: CGSize = CGSize(width: 50, height: 50), opacity: Double = 1.0) {
        self.imageName = imageName
        self.position = position
        self.size = size
        self.opacity = opacity
    }
}

struct ConversationStep {
    let text: String
    let characterImage: String
    let backgroundColor: Color
    let backgroundElements: [BackgroundElement]?
    let overlayElements: [OverlayElement]?

    init(text: String, characterImage: String, backgroundColor: Color, backgroundElements: [BackgroundElement]? = nil, overlayElements: [OverlayElement]? = nil) {
        self.text = text
        self.characterImage = characterImage
        self.backgroundColor = backgroundColor
        self.backgroundElements = backgroundElements
        self.overlayElements = overlayElements
    }
}

struct ContentView: View {
    @State private var currentStep = 0

    // Conversation flow data
    private let conversationSteps = [
        // Simple page 1
        ConversationStep(
            text: "안녕! 민준아",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Simple page 2
        ConversationStep(
            text: "나는 널 도와줄\n친구야!",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Simple page 3
        ConversationStep(
            text: "너에게 이름을\n지어줄래?",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Simple page 4
        ConversationStep(
            text: "와, 좋잖아!\n정말 멋진 이름이야",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Complex page 5 - with hearts overlay
        ConversationStep(
            text: "우리 잘 지내보자, 민준아\n나는 항상 네 곁에 있을게!",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            overlayElements: [
                OverlayElement(imageName: "heart", position: CGPoint(x: 50, y: 100), size: CGSize(width: 30, height: 30)),
                OverlayElement(imageName: "heart", position: CGPoint(x: 150, y: 80), size: CGSize(width: 25, height: 25)),
                OverlayElement(imageName: "heart", position: CGPoint(x: 180, y: 120), size: CGSize(width: 20, height: 20))
            ]
        ),

        // Simple page 6
        ConversationStep(
            text: "민준아, 나를 봐봐~",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Simple page 7
        ConversationStep(
            text: "너의 마음이 편해질때까지\n기다릴게",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Complex page 8 - Different background color with dummy heart rate
        ConversationStep(
            text: "100 BPM",
            characterImage: "orange_character_new",
            backgroundColor: Color.orange,
            backgroundElements: [
                BackgroundElement(imageName: "heartrate_line", position: CGPoint(x: 100, y: 150), size: CGSize(width: 200, height: 50))
            ]
        ),

        // Complex page 9 - Different background color
        ConversationStep(
            text: "80%",
            characterImage: "orange_character_new",
            backgroundColor: Color(red: 1.0, green: 0.7, blue: 0.6),
            backgroundElements: [
                BackgroundElement(imageName: "heartrate_line", position: CGPoint(x: 100, y: 160), size: CGSize(width: 180, height: 40))
            ]
        ),

        // Simple page 10
        ConversationStep(
            text: "잘했어!\n이제 나랑 이야기해보자",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Page 11 - Breathing intro
        ConversationStep(
            text: "이제 나를 따라서\n숨을 쉬어봐",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Page 12 - Breathing exercise 1
        ConversationStep(
            text: "숨을 들이 마셔서\n하나, 둘, 셋",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Page 13 - Breathing visual 1 (pill with flame)
        ConversationStep(
            text: "여기 있는\n촛불을 후 불어서 꺼줘!",
            characterImage: "",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            backgroundElements: [
                BackgroundElement(imageName: "breathing_pill", position: CGPoint(x: 100, y: 180), size: CGSize(width: 60, height: 120)),
                BackgroundElement(imageName: "flame_top", position: CGPoint(x: 100, y: 120), size: CGSize(width: 40, height: 60))
            ]
        ),

        // Page 14 - Breathing visual 2 (just pill)
        ConversationStep(
            text: "후 ~",
            characterImage: "",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            backgroundElements: [
                BackgroundElement(imageName: "breathing_pill", position: CGPoint(x: 100, y: 180), size: CGSize(width: 60, height: 120))
            ]
        ),

        // Page 15 - Continue breathing
        ConversationStep(
            text: "한번 더 해볼까?",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Page 16 - Breathing visual 3 (pill with flame)
        ConversationStep(
            text: "하나, 둘, 셋",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            backgroundElements: [
                BackgroundElement(imageName: "breathing_pill", position: CGPoint(x: 100, y: 180), size: CGSize(width: 60, height: 120)),
                BackgroundElement(imageName: "flame_top", position: CGPoint(x: 100, y: 120), size: CGSize(width: 40, height: 60))
            ]
        ),

        // Page 17 - Breathing visual 4 (just pill)
        ConversationStep(
            text: "후~",
            characterImage: "",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            backgroundElements: [
                BackgroundElement(imageName: "breathing_pill", position: CGPoint(x: 100, y: 180), size: CGSize(width: 60, height: 120))
            ]
        ),

        // Page 18 - End breathing
        ConversationStep(
            text: "잘했어!",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Page 19 - Introduction to stress relief
        ConversationStep(
            text: "사탕을\n먹어보면서 이완해볼까?",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Page 20 - Question about current mood
        ConversationStep(
            text: "우리 언제 브레킷짜?",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Page 21 - Start meditation with human character
        ConversationStep(
            text: "사랑을 3번 늘려봐!",
            characterImage: "human_character",
            backgroundColor: Color.black,
            backgroundElements: [
                BackgroundElement(imageName: "lollipop", position: CGPoint(x: 100, y: 200), size: CGSize(width: 50, height: 50))
            ]
        ),

        // Page 22 - Meditation step 1 with musical notes
        ConversationStep(
            text: "",
            characterImage: "human_character",
            backgroundColor: Color.black,
            backgroundElements: [
                BackgroundElement(imageName: "lollipop", position: CGPoint(x: 100, y: 200), size: CGSize(width: 50, height: 50))
            ],
            overlayElements: [
                OverlayElement(imageName: "music_note", position: CGPoint(x: 60, y: 100), size: CGSize(width: 20, height: 30)),
                OverlayElement(imageName: "music_note", position: CGPoint(x: 140, y: 120), size: CGSize(width: 25, height: 35))
            ]
        ),

        // Page 23 - Meditation step 2 with more musical notes
        ConversationStep(
            text: "",
            characterImage: "human_character_pink",
            backgroundColor: Color.black,
            backgroundElements: [
                BackgroundElement(imageName: "lollipop", position: CGPoint(x: 100, y: 200), size: CGSize(width: 50, height: 50))
            ],
            overlayElements: [
                OverlayElement(imageName: "music_note", position: CGPoint(x: 50, y: 90), size: CGSize(width: 20, height: 30)),
                OverlayElement(imageName: "music_note", position: CGPoint(x: 80, y: 110), size: CGSize(width: 25, height: 35)),
                OverlayElement(imageName: "music_note", position: CGPoint(x: 130, y: 100), size: CGSize(width: 20, height: 30)),
                OverlayElement(imageName: "music_note", position: CGPoint(x: 160, y: 120), size: CGSize(width: 25, height: 35))
            ]
        ),

        // Page 24 - Meditation final step with lightning bolts
        ConversationStep(
            text: "",
            characterImage: "human_character_red",
            backgroundColor: Color.black,
            overlayElements: [
                OverlayElement(imageName: "lightning_bolt", position: CGPoint(x: 70, y: 80), size: CGSize(width: 30, height: 40)),
                OverlayElement(imageName: "lightning_bolt", position: CGPoint(x: 120, y: 100), size: CGSize(width: 35, height: 45)),
                OverlayElement(imageName: "lightning_bolt", position: CGPoint(x: 90, y: 120), size: CGSize(width: 25, height: 35)),
                OverlayElement(imageName: "lightning_bolt", position: CGPoint(x: 150, y: 90), size: CGSize(width: 30, height: 40))
            ]
        ),

        // Page 25 - Reflection question 1
        ConversationStep(
            text: "봤지? 사탕을 많이 먹으면\n건강이 나빠질 수 있어!",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Page 26 - Reflection question 2
        ConversationStep(
            text: "사탕을 잘 참은\n친구도 보러 가볼까?",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Page 27 - Show completion with lollipop and sparkles
        ConversationStep(
            text: "사탕을 1번 놀려봐",
            characterImage: "human_character_happy",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            backgroundElements: [
                BackgroundElement(imageName: "lollipop", position: CGPoint(x: 100, y: 200), size: CGSize(width: 50, height: 50))
            ],
            overlayElements: [
                OverlayElement(imageName: "sparkle", position: CGPoint(x: 70, y: 120), size: CGSize(width: 25, height: 25)),
                OverlayElement(imageName: "sparkle", position: CGPoint(x: 140, y: 140), size: CGSize(width: 20, height: 20))
            ]
        ),

        // Page 28 - Success with more sparkles
        ConversationStep(
            text: "",
            characterImage: "human_character_happy",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            overlayElements: [
                OverlayElement(imageName: "sparkle", position: CGPoint(x: 50, y: 100), size: CGSize(width: 30, height: 30)),
                OverlayElement(imageName: "sparkle", position: CGPoint(x: 90, y: 80), size: CGSize(width: 25, height: 25)),
                OverlayElement(imageName: "sparkle", position: CGPoint(x: 130, y: 110), size: CGSize(width: 35, height: 35)),
                OverlayElement(imageName: "sparkle", position: CGPoint(x: 160, y: 90), size: CGSize(width: 20, height: 20)),
                OverlayElement(imageName: "big_sparkle", position: CGPoint(x: 100, y: 60), size: CGSize(width: 40, height: 40))
            ]
        ),

        // Page 29 - Return to orange character - final question
        ConversationStep(
            text: "어때? 맛지?",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        )
    ]

    private var currentConversationStep: ConversationStep {
        conversationSteps[currentStep]
    }

    var body: some View {
        ZStack {
            // Background color
            currentConversationStep.backgroundColor
                .ignoresSafeArea()

            // Background elements (behind character)
            if let backgroundElements = currentConversationStep.backgroundElements {
                ForEach(backgroundElements) { element in
                    Image(element.imageName)
                        .resizable()
                        .frame(width: element.size.width, height: element.size.height)
                        .position(element.position)
                        .opacity(element.opacity)
                }
            }

            VStack(spacing: 0) {
                // Korean text - fixed position at top
                Text(currentConversationStep.text)
                    .padding(.horizontal, 15)
                    .padding(.top, 30)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color(red: 0.0, green: 0.48, blue: 0.92))
                    .opacity(0.8)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(height: 80, alignment: .top)

                // Orange character image - only show if characterImage is not empty
                if !currentConversationStep.characterImage.isEmpty {
                    Image(currentConversationStep.characterImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 110)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                }
            }

            // Overlay elements (in front of character)
            if let overlayElements = currentConversationStep.overlayElements {
                ForEach(overlayElements) { element in
                    Image(element.imageName)
                        .resizable()
                        .frame(width: element.size.width, height: element.size.height)
                        .position(element.position)
                        .opacity(element.opacity)
                }
            }
        }
        .onTapGesture {
            // Advance to next step, loop back to start
            currentStep = (currentStep + 1) % conversationSteps.count
        }
    }
}

#Preview {
    ContentView()
}
