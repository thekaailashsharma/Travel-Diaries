//
//  SplashScreen.swift
//  Travel Diaries
//
//  Created by Kailash on 13/05/24.
//

import SwiftUI

struct SplashScreen: View {
    @Binding var isSplashVisible: Bool
    @State private var scaleIndices: [Int] = []
    @State private var showImages = true
    @State private var scaleDown = false
    @State private var fontScale: CGFloat = 1.0
    
    let images = ["trv1", "trv2", "trv3", "trv4", "trv5", "trv6"] // Replace with your image names
    
    var body: some View {
        if showImages {
            GeometryReader { geometry in
                
                ZStack {
                    ForEach(0..<images.count, id: \.self) { index in
                        let position = randomPosition(in: geometry.size)
                        Image(images[index])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width / 3, height: geometry.size.height / 3)
                            .position(position)
                            .scaleEffect(scaleIndices.contains(index) ? 1.5 : 1.0)
                            .scaleEffect(scaleDown ? 0.2 : 1.0)
                            .animation(.easeInOut(duration: 1.0), value: scaleIndices)
                            .onAppear {
                                if scaleIndices.count < 5 && !scaleIndices.contains(index) {
                                    scaleIndices.append(index)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.0...4.5)) {
                                        if let indexToRemove = scaleIndices.firstIndex(of: index) {
                                            scaleIndices.remove(at: indexToRemove)
                                        }
                                        
                                    }
                                }
                            }
                    }
                }
                .opacity(showImages ? 1.0 : 0.0)
                .animation(Animation.easeInOut(duration: 4.0).delay(4.0), value: scaleIndices)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        withAnimation(.bouncy) {
                            scaleDown = true
//                            showImages = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation(Animation.easeInOut(duration: 0.05)) {
                                    showImages = false
                                }
                            }
                        }
                        
                    }
                }
            }
        }
            else {
                VStack {
                    
                    Text("Travel Diaries")
                        .font(.customFont(.frosting, size: 20))
                        .scaleEffect(fontScale)
                }
                .onAppear {
                    withAnimation(.bouncy(duration: 2.0)) {
                        fontScale = 2.0
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation(Animation.easeInOut(duration: 0.05)) {
                                isSplashVisible = false
                            }
                        }
                    }
                }
                    
            }
        }
    }
    
    func randomPosition(in size: CGSize) -> CGPoint {
        return CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height))
    }






//#Preview {
//    SplashScreen()
//}
