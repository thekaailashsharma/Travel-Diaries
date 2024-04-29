//
//  ContentView.swift
//  Travel Diaries
//
//  Created by Kailash on 28/04/24.
//

import SwiftUI
import SceneKit
import SceneKit.ModelIO

struct ContentView: View {
    
    @State var isStarted: Bool = true
    @State var isStarted2: Bool = false
    @State var isStarted3: Bool = false
    @State var isPhase2Started: Bool = false
    @State var isPhase1Started: Bool = false
    @State var isPhase3Started: Bool = false
    @State var animationCount: Int = 0
    
    
    var body: some View {
        VStack {
            VStack {
                
                ZStack {
                    if isPhase1Started {
                        VStack {
                            HStack {
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 80, height: 80) // Circle size
                                    .overlay(
                                        Image("trv1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80) // Image size
                                            .foregroundColor(.white) // Image color
                                    )
                                    .offset(x: !isStarted ? -65 : 65,
                                            y: !isStarted ? -50 : 0)
                                    .opacity(!isStarted ? 1 : 0)
                                
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 80, height: 80) // Circle size
                                    .overlay(
                                        Image("trv2")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80) // Image size
                                            .foregroundColor(.white) // Image color
                                    )
                                    .offset(x: !isStarted ? 65 : -65,
                                            y: !isStarted ? -50 : 0)
                                    .opacity(!isStarted ? 1 : 0)
                            }
                            HStack {
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 80, height: 80) // Circle size
                                    .overlay(
                                        Image("trv3")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80) // Image size
                                            .foregroundColor(.white) // Image color
                                    )
                                    .offset(x: !isStarted ? -65 : 65,
                                            y: !isStarted ? -50 : -85)
                                    .opacity(!isStarted ? 1 : 0)
                                
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 80, height: 80) // Circle size
                                    .overlay(
                                        Image("trv4")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80) // Image size
                                            .foregroundColor(.white) // Image color
                                    )
                                    .offset(x: !isStarted ? 65 : -65,
                                            y: !isStarted ? -50 : -85)
                                    .opacity(!isStarted ? 1 : 0)
                            }
                            .offset(y: 60)
                        }
                    }
                    if isPhase3Started {
                        HStack {
                            Circle()
                                .fill(Color.purple.gradient) // Circle color
                                .frame(width: 120, height: 120) // Circle size
                                .overlay(
                                    Image("me1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 120, height: 120) // Image size
                                        .foregroundColor(.white) // Image color
                                )
                                .offset(x: isStarted3 ? -25 : 65,
                                        y: isStarted3 ? -20 : 0)
                                .opacity(isStarted3 ? 1 : 0)
                            Circle()
                                .fill(Color.red.gradient) // Circle color
                                .frame(width: 120, height: 120) // Circle size
                                .overlay(
                                    Image("me2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 120, height: 120) // Image size
                                        .foregroundColor(.white) // Image color
                                )
                                .offset(x: isStarted3 ? 25 : -65,
                                        y: isStarted3 ? -20 : 0)
                                .opacity(isStarted3 ? 1 : 0)
                        }
                    }
                    if isPhase2Started {
                        VStack {
                            HStack {
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 80, height: 80) // Circle size
                                    .overlay(
                                        Image("trv5")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80) // Image size
                                            .foregroundColor(.white) // Image color
                                    )
                                    .offset(x: !isStarted2 ? -65 : 65,
                                            y: !isStarted2 ? -50 : 0)
                                    .opacity(!isStarted2 ? 1 : 0)
                                
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 80, height: 80) // Circle size
                                    .overlay(
                                        Image("trv6")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80) // Image size
                                            .foregroundColor(.white) // Image color
                                    )
                                    .offset(x: !isStarted2 ? 65 : -65,
                                            y: !isStarted2 ? -50 : 0)
                                    .opacity(!isStarted2 ? 1 : 0)
                            }
                            HStack {
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 80, height: 80) // Circle size
                                    .overlay(
                                        Image("trv7")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80) // Image size
                                            .foregroundColor(.white) // Image color
                                    )
                                    .offset(x: !isStarted2 ? -65 : 65,
                                            y: !isStarted2 ? -50 : -85)
                                    .opacity(!isStarted2 ? 1 : 0)
                                
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 80, height: 80) // Circle size
                                    .overlay(
                                        Image("trv8")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80) // Image size
                                            .foregroundColor(.white) // Image color
                                    )
                                    .offset(x: !isStarted2 ? 65 : -65,
                                            y: !isStarted2 ? -50 : -85)
                                    .opacity(!isStarted2 ? 1 : 0)
                            }
                            .offset(y: 60)
                        }
                    }
                    
                    Circle()
                        .fill(Color.yellow) // Circle color
                        .frame(width: 120, height: 120) // Circle size
                        .overlay(
                            Image(isPhase1Started ? "me1" : isPhase2Started ? "me2" : isPhase3Started ? "me" : "me1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120) // Image size
                                .foregroundColor(.white) // Image color
                        )
                    
                }
                
                
                
            }
            .padding(.top, 95)
            Spacer()
            Button {
                startAnimation()
            } label: {
                Text("Start Now")
            }
            .padding()
            
        }
    }
    func startAnimation() {
        withAnimation(.interactiveSpring(duration: 1).repeatForever(autoreverses: true)) {
            isPhase1Started = true
            isPhase3Started = false
            isPhase2Started = false
            isStarted = false
            isStarted2 = false
            isStarted3 = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.interactiveSpring(duration: 1)) {
                    isStarted = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.interactiveSpring(duration: 1)) {
                            isPhase2Started = true
                            isPhase3Started = false
                            isPhase1Started = false
                            isStarted2 = true
                            isStarted = false
                            isStarted3 = false
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.interactiveSpring(duration: 1)) {
                                    isStarted2 = false
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        withAnimation(.interactiveSpring(duration: 1)) {
                                            isStarted2 = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                                withAnimation(.interactiveSpring(duration: 1)) {
                                                    isPhase3Started = true
                                                    isPhase2Started = false
                                                    isPhase1Started = false
                                                    isStarted3 = true
                                                    isStarted2 = false
                                                    isStarted = false
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                                        withAnimation(.interactiveSpring(duration: 1)) {
                                                            isStarted3 = false
                                                            
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                                                withAnimation(.interactiveSpring(duration: 1)) {
                                                                    animationCount += 1
                                                                    if animationCount <= 2 {
                                                                        startAnimation()
                                                                    } else {
                                                                        isStarted3 = true
                                                                    }
                                                                }
                                                            }
                                                            
                                                        }
                                                    }
                                                    
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                            }
                            
                            // Restart the animation after 6.5 seconds
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
