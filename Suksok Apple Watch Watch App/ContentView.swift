//
//  ContentView.swift
//  Suksok Apple Watch Watch App
//
//  Created by Yehezkiel Alexander on 11/3/25.
//

import SwiftUI
import WatchKit

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
    let imageName: String?
    let text: String?
    let position: CGPoint
    let size: CGSize
    let opacity: Double
    let fontSize: CGFloat
    let textColor: Color

    init(imageName: String, position: CGPoint, size: CGSize = CGSize(width: 50, height: 50), opacity: Double = 1.0) {
        self.imageName = imageName
        self.text = nil
        self.position = position
        self.size = size
        self.opacity = opacity
        self.fontSize = 16
        self.textColor = .black
    }

    init(text: String, position: CGPoint, fontSize: CGFloat = 16, textColor: Color = .black, opacity: Double = 1.0) {
        self.imageName = nil
        self.text = text
        self.position = position
        self.size = CGSize.zero
        self.opacity = opacity
        self.fontSize = fontSize
        self.textColor = textColor
    }
}

struct ConversationStep {
    let text: String
    let characterImage: String
    let backgroundColor: Color
    let textColor: Color
    let fontSize: CGFloat
    let characterImageSize: CGSize
    let characterImageOffset: CGFloat
    let enableVibration: Bool
    let backgroundElements: [BackgroundElement]?
    let overlayElements: [OverlayElement]?

    init(text: String, characterImage: String, backgroundColor: Color, textColor: Color = Color(red: 0.0, green: 0.48, blue: 0.92), fontSize: CGFloat = 20, characterImageSize: CGSize = CGSize(width: 160, height: 130), characterImageOffset: CGFloat = 0, enableVibration: Bool = false, backgroundElements: [BackgroundElement]? = nil, overlayElements: [OverlayElement]? = nil) {
        self.text = text
        self.characterImage = characterImage
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.fontSize = fontSize
        self.characterImageSize = characterImageSize
        self.characterImageOffset = characterImageOffset
        self.enableVibration = enableVibration
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
            text: "와, 콩콩이!\n멋진 이름이야",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Complex page 5 - with hearts overlay
        ConversationStep(
            text: "잘 지내보자,\n항상 네 옆에 있을게",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            overlayElements: [
                OverlayElement(imageName: "heart", position: CGPoint(x: 40, y: 85), size: CGSize(width: 20, height: 20)),
                OverlayElement(imageName: "heart", position: CGPoint(x: 20, y: 150), size: CGSize(width: 20, height: 20)),
                OverlayElement(imageName: "heart", position: CGPoint(x: 140, y: 120), size: CGSize(width: 20, height: 20))
            ]
        ),

        // Simple page 6
        ConversationStep(
            text: "민준아, 나좀 봐봐~",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Simple page 7
        ConversationStep(
            text: "너의 마음이\n편해질때까지\n기다릴게",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Complex page 8 - Different background color with dummy heart rate
        ConversationStep(
            text: "심장이 정말 빨리\n뛰고 있어",
            characterImage: "orange_character_new",
            backgroundColor: Color.orange,
            textColor: .black,
            enableVibration: true,  // Enables vibration for this step
            backgroundElements: [
                BackgroundElement(imageName: "heartrate_line_atas", position: CGPoint(x: 100, y: 90), size: CGSize(width: 200, height: 50)),
                BackgroundElement(imageName: "heartrate_line_bawah", position: CGPoint(x: 100, y: 135), size: CGSize(width: 200, height: 50))
            ],
            overlayElements: [
                OverlayElement(text: "100", position: CGPoint(x: 70, y: 80), fontSize: 24, textColor: Color(red: 1.0, green: 1, blue: 1)),
                OverlayElement(text: "BPM", position: CGPoint(x: 105, y: 83), fontSize: 12, textColor: Color(red: 1.0, green: 1, blue: 1))
            ]
        ),

        // Complex page 9 - Different background color
        ConversationStep(
            text: "원래 모습으로\n돌아오고 있어",
            characterImage: "orange_character_new",
            backgroundColor: Color(red: 1.0, green: 0.7, blue: 0.6),
            textColor: .gray,
            enableVibration: true,  // Enables vibration for this step


            backgroundElements: [
                BackgroundElement(imageName: "heartrate", position: CGPoint(x: 100, y: 100), size: CGSize(width: 200, height: 50))
            ],
            overlayElements: [
                OverlayElement(text: "80", position: CGPoint(x: 70, y: 80), fontSize: 24, textColor: Color(red: 1.0, green: 1, blue: 1)),
                OverlayElement(text: "BPM", position: CGPoint(x: 100, y: 83), fontSize: 12, textColor: Color(red: 1, green: 1, blue: 1))
            ]
        ),

        // Simple page 10
        ConversationStep(
            text: "잘했어!\n이제 이야기해보자",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            enableVibration: true,  // Enables vibration for this step

            backgroundElements: [
                BackgroundElement(imageName: "heartrate_terakhir", position: CGPoint(x: 100, y: 100), size: CGSize(width: 200, height: 50))
            ],
            overlayElements: [
                OverlayElement(text: "80", position: CGPoint(x: 70, y: 80), fontSize: 24, textColor: Color(red: 0.0, green: 0.48, blue: 0.92)),
                OverlayElement(text: "BPM", position: CGPoint(x: 100, y: 83), fontSize: 12, textColor: Color(red: 0.0, green: 0.48, blue: 0.92))
            ]
        ),

        // Page 11 - Breathing intro
        ConversationStep(
            text: "이제 나를 따라서\n숨을 쉬어봐",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Page 12 - Breathing exercise 1
        ConversationStep(
            text: "코로 들이 마셔봐\n하나, 둘, 셋",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Page 13 - Breathing visual 1 (pill with flame)
        ConversationStep(
            text: "이제 여기 있는\n촛불을 꺼보자",
            characterImage: "candle_light",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            characterImageOffset: -30 ,
            backgroundElements: [
//                BackgroundElement(imageName: "candle_light", position: CGPoint(x: 100, y: 180), size: CGSize(width: 60, height: 120)),
            ]
        ),

        // Page 14 - Breathing visual 2 (just pill)
        ConversationStep(
            text: "후 ~",
            characterImage: "candle_no_light",
            
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            characterImageSize: CGSize(width: 80, height: 80),
//            backgroundElements: [
//                BackgroundElement(imageName: "breathing_pill", position: CGPoint(x: 100, y: 180), size: CGSize(width: 60, height: 120))
//            ]
        ),

        // Page 15 - Continue breathing
        ConversationStep(
            text: "한번 더 해볼까?",
            characterImage: "candle_light",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            characterImageOffset: -30 ,
            backgroundElements: [
//                BackgroundElement(imageName: "candle_light", position: CGPoint(x: 100, y: 180), size: CGSize(width: 60, height: 120)),
            ]
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
            text: "후 ~",
            characterImage: "candle_no_light",
            
            
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            
            characterImageSize: CGSize(width: 80, height: 80),
            
            enableVibration: true,  // Enables vibration for this step

//            backgroundElements: [
//                BackgroundElement(imageName: "breathing_pill", position: CGPoint(x: 100, y: 180), size: CGSize(width: 60, height: 120))
//            ]
        ),

        // Page 18 - End breathing
        ConversationStep(
            text: "잘했어!",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        
        ConversationStep(
            text: "이제 나에게\n너의 기분을 알려줘",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        
        ConversationStep(
            text: "이제 나에게\n너의 기분을 알려줘",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            enableVibration: true,  // Enables vibration for this step

            overlayElements: [
                OverlayElement(imageName: "ellipse", position: CGPoint(x: 90, y: 100), size: CGSize(width: 250, height: 250)),
                OverlayElement(imageName: "microphone-2", position: CGPoint(x: 90, y: 100), size: CGSize(width: 40, height: 40))
            ]
        ),
        
        ConversationStep(
            text: "너가 슬프니까\n나도 마음이 안 좋아",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        
        ConversationStep(
            text: "왜 슬펐는지\n말해줄 수 있어?",
            characterImage: "orange_sad",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
        ),
        
        
        ConversationStep(
            text: "왜 슬펐는지\n말해줄 수 있어?",
            characterImage: "orange_sad",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            enableVibration: true,  // Enables vibration for this step

            overlayElements: [
                OverlayElement(imageName: "ellipse", position: CGPoint(x: 90, y: 100), size: CGSize(width: 250, height: 250)),
                OverlayElement(imageName: "microphone-2", position: CGPoint(x: 90, y: 100), size: CGSize(width: 40, height: 40))
            ]
        ),
        
        
        
        ConversationStep(
            text: "왜 슬펐는지\n말해줄 수 있어?",
            characterImage: "oraneg_idk",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        
        ConversationStep(
            text: "민준아, 나도 너처럼\n밥을 무척 좋아해!",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        
        ConversationStep(
            text: "근데 밥을\n너무 많이 먹으면",
            characterImage: "orange_maybe",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        
        ConversationStep(
            text: "배가 아플 수도 있어",
            characterImage: "orange_maybe",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        

        ConversationStep(
            text: "밥을 더\n먹으면 어떻게 될까?",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Page 20 - Question about current mood
        ConversationStep(
            text: "우리 같이\n보러갈래?",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Page 21 - Start meditation with human character
        ConversationStep(
            text: "\n밥을 3번 늘려봐!",
            characterImage: "kid_grey",
            backgroundColor: Color.black,
            textColor: .white,
            fontSize: 19,  // Larger text

            
            characterImageSize: CGSize(width: 200, height: 150),  // Smaller character
            characterImageOffset: -30,  // Moves image up by 30 points

            enableVibration: true,  // Enables vibration for this step

            overlayElements: [
                OverlayElement(imageName: "rice", position: CGPoint(x: 100, y: 175), size: CGSize(width: 50, height: 50))
            ]
        ),

        // Page 22 - Meditation step 1 with musical notes
        ConversationStep(
            text: "",
            characterImage: "kid_1",
            backgroundColor: Color.black,
            characterImageSize: CGSize(width: 250, height: 200),  // Smaller character
            characterImageOffset: -80,  // Moves image up by 30 points
            enableVibration: true,  // Enables vibration for this step

            overlayElements: [
                OverlayElement(imageName: "rice", position: CGPoint(x: 120, y: 175), size: CGSize(width: 50, height: 50))
            ]
            
        ),

        // Page 23 - Meditation step 2 with more musical notes
        ConversationStep(
            text: "",
            characterImage: "kid_2",
            backgroundColor: Color.black,
            characterImageSize: CGSize(width: 250, height: 180),
            characterImageOffset: -60,  // Moves image up by 30 points
            enableVibration: true,  // Enables vibration for this step
            overlayElements: [
                OverlayElement(imageName: "rice", position: CGPoint(x: 120, y: 175), size: CGSize(width: 50, height: 50))
            ]

           
        ),

        // Page 24 - Meditation final step with lightning bolts
        ConversationStep(
            text: "",
            characterImage: "kid_3",
            backgroundColor: Color.black,
            characterImageSize: CGSize(width: 250, height: 180),
            
            characterImageOffset: -60,
            enableVibration: true,  // Enables vibration for this step


           
        ),

        // Page 25 - Reflection question 1
        ConversationStep(
            text: "봤지? 밥을 많이\n먹으면 건강이 나빠져",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),

        // Page 26 - Reflection question 2
        ConversationStep(
            text: "밥을 한 그긋만\n친구도 보러 가볼까?",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),


        ),

//         Page 27 - Show completion with lollipop and sparkles
        ConversationStep(
            text: "밥을 한 그릇 먹어봐!",
            characterImage: "kid_grey",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            characterImageSize: CGSize(width: 200, height: 150),  // Smaller character
            characterImageOffset: -30,
            enableVibration: true,  // Enables vibration for this step



            overlayElements: [
                OverlayElement(imageName: "rice", position: CGPoint(x: 100, y: 180), size: CGSize(width: 50, height: 50))
            ]
        ),

        // Page 28 - Success with more sparkles
        ConversationStep(
            text: "",
            characterImage: "happy_kid",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            characterImageSize: CGSize(width: 250, height: 150),  // Smaller character
            characterImageOffset: -30,
            enableVibration: true,  // Enables vibration for this step



        ),

        // Page 29 - Return to orange character - final question
        ConversationStep(
            text: "어때? 멋지지?",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        
        // Page 29 - Return to orange character - final question
        ConversationStep(
            text: "민준이도 밥은\n한 그릇만",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        
        ConversationStep(
            text: "먹어보는거 어때?",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        ConversationStep(
            text: "먹어보는거 어때?",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97),
            enableVibration: true,  // Enables vibration for this step

            overlayElements: [
                OverlayElement(imageName: "ellipse", position: CGPoint(x: 90, y: 100), size: CGSize(width: 250, height: 250)),
                OverlayElement(imageName: "microphone-2", position: CGPoint(x: 90, y: 100), size: CGSize(width: 40, height: 40))
            ]
        ),
        
        ConversationStep(
            text: "약속해줘서\n정말 고마워!",
            characterImage: "orange_maybe",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        
        ConversationStep(
            text: "그리고 그거 알아?",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        
        ConversationStep(
            text: "엄마가 민준이를\n엄청 사랑해서",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        
        ConversationStep(
            text: "못 먹게 하신거야!",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        
        ConversationStep(
            text: "우리 오늘 한 약속\n잘 지켜나가보자",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        ConversationStep(
            text: "그리고 언제든\n너를 찾아올게!",
            characterImage: "orangecharacter",
            backgroundColor: Color(red: 0.89, green: 0.93, blue: 0.97)
        ),
        ConversationStep(
            text: "나는 너의 친구야!",
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
                    .padding(.top, 10)
                    .font(.system(size: currentConversationStep.fontSize, weight: .semibold))
                    .foregroundColor(currentConversationStep.textColor)
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
                        .frame(width: currentConversationStep.characterImageSize.width, height: currentConversationStep.characterImageSize.height)
                        .padding(.top, 10 + currentConversationStep.characterImageOffset)
                        .padding(.bottom, -10)
                }
            }

            // Overlay elements (in front of character)
            if let overlayElements = currentConversationStep.overlayElements {
                ForEach(overlayElements) { element in
                    if let imageName = element.imageName {
                        // Render image overlay
                        Image(imageName)
                            .resizable()
                            .frame(width: element.size.width, height: element.size.height)
                            .position(element.position)
                            .opacity(element.opacity)
                    } else if let text = element.text {
                        // Render text overlay
                        Text(text)
                            .font(.system(size: element.fontSize, weight: .bold))
                            .foregroundColor(element.textColor)
                            .position(element.position)
                            .opacity(element.opacity)
                    }
                }
            }
        }
        .onTapGesture {
            // Advance to next step, loop back to start
            currentStep = (currentStep + 1) % conversationSteps.count

            // Trigger vibration if enabled for the new step
            if currentConversationStep.enableVibration {
                WKInterfaceDevice.current().play(.notification)
            }
        }
        .onAppear {
            // Trigger vibration when view first appears if enabled
            if currentConversationStep.enableVibration {
                WKInterfaceDevice.current().play(.notification)
            }
        }
    }
}

#Preview {
    ContentView()
}
