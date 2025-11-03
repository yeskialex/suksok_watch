//
//  ContentView.swift
//  Suksok Apple Watch Watch App
//
//  Created by Yehezkiel Alexander on 11/3/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Korean greeting text
            Text("안녕! 민준아")
                .padding()
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color(red: 0.0, green: 0.48, blue: 0.92))
                .opacity(0.8)

            Spacer()

            // Orange character image
            Image("orangecharacter")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160, height: 120)
        }
        .padding(.top, 64)
        .padding(.bottom, 90)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.89, green: 0.93, blue: 0.97))
    }
}

#Preview {
    ContentView()
}
