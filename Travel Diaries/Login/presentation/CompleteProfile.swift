//
//  CompleteProfile.swift
//  Travel Diaries
//
//  Created by Kailash on 30/04/24.
//

import SwiftUI

struct CompleteProfile: View {
    
    @EnvironmentObject var authManager: AuthManager
    
    @State var phoneNumber: String = ""
    @State var countryCode: String = "IN"
    @State var smsCode: String = ""
    @State var userName: String = ""
    @State var progressText: String = "You will be redirected !!"
    @State var isLoading: Bool = false
    @State var currentProfileScreen: CompleteProfileValues = .phoneNumber
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    switch currentProfileScreen {
                    case .phoneNumber:
                        EnterPhoneNumber(number: $phoneNumber, countryCode: $countryCode) {
                            
                            isLoading = true
                            authManager.startAuth(phoneNumber: "+\(getCountryCode(countryCode))\(phoneNumber)") { value in
                                isLoading = false
                                if value {
                                    withAnimation(.spring.delay(1)) {
                                        currentProfileScreen = .otp
                                    }
                                }
                            }
                        }
                            
                    case .otp:
                        CustomTextField(textValue: $smsCode, keyboardType: .numberPad, label: "Enter OTP") {
                            
                            isLoading = true
                            progressText = "Please Wait"
                            authManager.verifyCode(smsCode: smsCode) { value in
                                isLoading = false
                                if value {
                                    authManager.getLoginStatus()
                                    print("Hurray")
                                    withAnimation(.spring.delay(1)) {
                                        currentProfileScreen = .username
                                    }
                                    
                                }
                            }
                            
                           
                        }
                        .transition(.slide)
                        .animation(.easeInOut, value: currentProfileScreen)
                        .padding()
                    case .username:
                        CustomTextField(textValue: $userName, keyboardType: .default, label: "Enter Username") {
                            
                        }
                        .transition(.slide)
                        .animation(.easeInOut, value: currentProfileScreen)
                        .padding()
                    }
                    Spacer()
                    
                }
                .blur(radius: isLoading ? 10: 0)
                
                if isLoading {
                    ProgressView {
                        Text(progressText)
                            .font(.customFont(.poppins, size: 25))
                            .foregroundStyle(.white)
                    }
                    .animation(.bouncy, value: isLoading)
                }
                
            }
            .navigationTitle(currentProfileScreen.rawValue)
        }
    }
}

enum CompleteProfileValues: String {
    case phoneNumber = "Phone Number"
    case otp = "OTP"
    case username = "Username"
}

struct CustomTextField: View {
    @Binding var textValue: String
    var keyboardType: UIKeyboardType
    var label: String
    var isPhoneNumber: Bool = false
    @FocusState var isKeyBoardActive: Bool
    var onClick: () -> Void
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack {
                TextField(text: $textValue, label: {
                    Text(label)
                        .font(.customFont(.poppins, size: 15))
                        .padding()
                })
                .submitLabel(.go)
                .keyboardType(keyboardType)
                .focused($isKeyBoardActive)
                .onSubmit {
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
            .onAppear {
                isKeyBoardActive = true
            }
            Spacer()
            Button(action: {
                onClick()
            }, label: {
                Text("Proceed Ahead")
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
            
        }
        .frame(width: 350, height: 300, alignment: .top)
    }
    
}


struct EnterPhoneNumber: View {
    @Binding var number: String
    @Binding var countryCode: String
    @FocusState var isNumberActive: Bool
    var onClick: () -> Void
    let darkBlue = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    var body: some View {
        VStack {
            Spacer()
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
                .keyboardType(.numberPad)
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
            Spacer()
            Button(action: {
                onClick()
            }, label: {
                Text("Proceed Ahead")
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
        }
        .animation(.easeInOut, value: isNumberActive)
        .padding()
        .frame(width: 350, height: 300, alignment: .top)
        .onAppear(perform: {
            isNumberActive = true
        })
        
    }
}

#Preview {
    CompleteProfile()
}
