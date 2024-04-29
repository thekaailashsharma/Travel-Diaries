//
//  ContentView.swift
//  Travel Diaries
//
//  Created by Kailash on 28/04/24.
//

import SwiftUI
import SceneKit
import SceneKit.ModelIO
import AVKit

struct ContentsView: View {
    
    @StateObject var authManager = AuthManager()
    
//    init(){
//        for family in UIFont.familyNames {
//            print(family)
//            
//            for names in UIFont.fontNames(forFamilyName: family){
//                print("== \(names)")
//            }
//        }
//    }
    
    @State var phoneNumber: String = ""
    @State var countryCode: String = "IN"
    @State var smsCode: String = ""
    @State var progressText: String = "You will be redirected !!"
    @State var isOTPVisible: Bool = false
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            VideoBackgroundView(videoURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/palmapi-b548f.appspot.com/o/aaw.mp4?alt=media&token=3859f136-a47a-4b5a-b079-b643c8ad43aa")!)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(LinearGradient(colors: [.black, .black.opacity(0.8), .black.opacity(0.7)], startPoint: .bottom, endPoint: .top))
                    .frame(height: UIScreen.main.bounds.height / 2.4)
                    .overlay {
                        VStack {
                            ZStack {
                                
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
                                        .offset(x: -25 ,
                                                y:-20 )
                                    
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
                                        .offset(x: 25 ,
                                                y:-20 )
                                }
                                
                                Circle()
                                    .fill(Color.yellow) // Circle color
                                    .frame(width: 120, height: 120) // Circle size
                                    .overlay(
                                        Image("me")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 120, height: 120) // Image size
                                            .foregroundColor(.white) // Image color
                                    )
                            }
                            .offset(y: -35)
                            Spacer()
                            
                            ZStack {
                                VStack {
                                    VStack {
                                        Text("Travel Diaries")
                                            .font(.customFont(.frosting, size: 30))
                                            .foregroundStyle(.white)
                                        
                                        Text("An app you never asked for")
                                            .font(.customFont(.poppins, size: 12))
                                            .foregroundStyle(.white)
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                       
                                    }, label: {
                                        Text("Take Me In")
                                            .font(.customFont(.poppins, size: 20))
                                            .foregroundStyle(.white)
                                            .padding()
                                            .frame(width: 300)
                                            .background(Color(uiColor: .black).opacity(0.6))
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.white.opacity(0.5))
                                            }
                                        
                                    })
                                    
                                    Spacer()
                                   
                                    
//                                    EnterPhoneNumber(number: $phoneNumber, countryCode: $countryCode, smsCode: $smsCode, isOTPVisble: $isOTPVisible) {
//                                        if !isOTPVisible {
//                                            isLoading = true
//                                            authManager.startAuth(phoneNumber: "+\(getCountryCode(countryCode))\(phoneNumber)") { value in
//                                                isLoading = false
//                                                if value {
//                                                    withAnimation(.spring.delay(1)) {
//                                                        isOTPVisible.toggle()
//                                                    }
//                                                }
//                                            }
//                                        } else {
//                                            isLoading = true
//                                            progressText = "Please Wait"
//                                            authManager.verifyCode(smsCode: smsCode) { value in
//                                                isLoading = false
//                                                if value {
//                                                    authManager.getLoginStatus()
//                                                    print("Hurray")
//                                                }
//                                            }
//                                        }
//                                        
//                                    }
                                }
//                                .rotation3DEffect(.degrees(isOTPVisible ? 0 : -180), axis: (x: 0, y: 1, z: 0))
//                                .scaleEffect(x: !isOTPVisible ? -1 : 1, y: 1)
//                                .animation(.spring, value: isOTPVisible)
                                
                                
                                
                            }
                            
                            if isLoading {
                                ProgressView {
                                    Text(progressText)
                                        .font(.customFont(.poppins, size: 25))
                                        .foregroundStyle(.white)
                                }
                                .animation(.bouncy, value: isLoading)
                            }
                        }
                    }
                    .blur(radius: isLoading ? 10: 0)
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct VideoBackgroundView: UIViewRepresentable {
    let videoURL: URL
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        // Add AVPlayerLayer for video
        let player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = UIScreen.main.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        
        // Add black gradient overlay
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.0]
        gradientLayer.frame = UIScreen.main.bounds
        view.layer.addSublayer(gradientLayer)
        
        
        // Play the video in loop
        player.play()
        player.isMuted = true
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { _ in
            player.seek(to: .zero)
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update view if needed
    }
}


struct EnterPhoneNumber: View {
    @Binding var number: String
    @Binding var countryCode: String
    @Binding var smsCode: String
    @Binding var isOTPVisble: Bool
    @FocusState var isNumberActive: Bool
    @FocusState var isOTPActive: Bool
    var onClick: () -> Void
    let darkBlue = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    var body: some View {
        VStack {
            if !isOTPVisble {
                HStack {
                    Picker(selection: $countryCode) {
                        ForEach(countryDictionary.sorted(by: <), id: \.key) { key , value in
                            HStack {
                                Text("\(countryName(countryCode: key) ?? key)").tag(value)
                            }
                            
                        }
                    } label: {
                        Text("+\(countryCode)")
                    }
                    
                    
                    
                    TextField(text: $number, label: {
                        Text("Enter Phone Number")
                            .font(.customFont(.poppins, size: 15))
                            .padding()
                    })
                    .submitLabel(.continue)
                    .keyboardType(.default)
                    .focused($isNumberActive)
                    .onSubmit {
                        isNumberActive.toggle()
                        onClick()
                    }
                    .font(.customFont(.poppins, size: 18))
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.5))
                    }
                }
            }
            else {
                HStack {
                    TextField(text: $smsCode, label: {
                        Text("Enter OTP Here.")
                            .font(.customFont(.poppins, size: 15))
                            .padding()
                    })
                    .submitLabel(.go)
                    .keyboardType(.default)
                    .focused($isOTPActive)
                    .onSubmit {
                        isOTPActive.toggle()
                        onClick()
                    }
                    .font(.customFont(.poppins, size: 18))
                    .keyboardType(.numberPad)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.5))
                    }
                }
            }
            Spacer()
            Button(action: {
                onClick()
            }, label: {
                Text(isOTPVisble ? "Take Me In" : "Proceed Ahead")
                    .font(.customFont(.poppins, size: 20))
                    .foregroundStyle(.white)
                    .padding()
                    .frame(width: 300)
                    .background(Color(uiColor: .black).opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white.opacity(0.5))
                    }
                
            })
            Spacer()
            HStack {
                Circle()
                    .fill(isOTPVisble ? .white.opacity(0.6): .white)
                    .frame(width: 10, height: 10)
                
                Circle()
                    .fill(!isOTPVisble ? .white.opacity(0.6): .white)
                    .frame(width: 10, height: 10)
                
            }
        }
        .animation(.easeInOut, value: isNumberActive)
        .animation(.easeInOut, value: isOTPActive)
        .padding()
        .frame(width: 350, height: 300, alignment: .top)
        
    }
}

#Preview {
    ContentsView()
}
