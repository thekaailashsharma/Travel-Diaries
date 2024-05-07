//
//  PermissionsCard.swift
//  Travel Diaries
//
//  Created by Kailash on 07/05/24.
//

import SwiftUI

var yellow = #colorLiteral(red: 0.9513035417, green: 0.7191032171, blue: 0.2411221564, alpha: 1)
var red = #colorLiteral(red: 0.9960784314, green: 0.1647058824, blue: 0.1647058824, alpha: 1)
var blue = #colorLiteral(red: 0.1058823529, green: 0.2823529412, blue: 0.6196078431, alpha: 1)

struct MarqueeIcon: Identifiable {
    var id: UUID = .init()
    var name: String
    var color: Color
    var icon: String
}

var iconsList = [
    MarqueeIcon(name: "Photos", color: Color(uiColor: blue), icon: "ios-photos"),
    MarqueeIcon(name: "Photos", color: Color(uiColor: blue), icon: "ios-photos"),
    MarqueeIcon(name: "Photos", color: Color(uiColor: blue), icon: "ios-photos"),
]

struct PermissionsCard: View {
        
    @EnvironmentObject var photoPicker: PhotoPickerViewController
    
    var body: some View {
        
        ZStack {
            Color(.black).ignoresSafeArea()
            Group {
                VStack {
                    VStack {
                        ForEach(1...5, id: \.self) { _ in
                            HStack(spacing: 20) {
                                ForEach(1...min(iconsList.count, Int(UIScreen.main.bounds.width / 100)) + 1 , id: \.self) { _ in
                                    let icon = iconsList[Int.random(in: 0..<3)]
                                    MarqueeCard(icon: icon)
                                        .frame(width: 120)
                                        .padding(.all, 4)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(icon.color)
                                        }
                                    
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            
                        }
                    }
                    .opacity(0.6)
                    Spacer()
                }
            }
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(LinearGradient(colors: [.black, .black.opacity(0.6), .black.opacity(0.4)], startPoint: .bottom, endPoint: .top))
                    .frame(height: UIScreen.main.bounds.height / 1.4)
            }
            
            VStack {
                Spacer()
                Button {
                    photoPicker.requestPhotoLibraryAccess()
                } label: {
                    VStack(spacing: 20) {
                        switch photoPicker.authStatus {
                        case .notDetermined:
                            Text("Allow Permission to access All Photos")
                                .font(.customFont(.poppins, size: 19))
                                .foregroundStyle(Color.customColor(.green))
                            
                            Text("We need all photos access to make your tagging easier.")
                                .font(.customFont(.poppins, size: 13))
                                .foregroundStyle(Color.customColor(.gray))
                        case .restricted, .denied:
                            Text("Open Settings & Grant Access")
                                .font(.customFont(.poppins, size: 19))
                                .foregroundStyle(Color.customColor(.green))
                            
                            Text("Seems we have restricted access 😕")
                                .font(.customFont(.poppins, size: 13))
                                .foregroundStyle(Color.customColor(.gray))
                        case .authorized:
                            Text("Allow Permission to access All Photos")
                                .font(.customFont(.poppins, size: 19))
                                .foregroundStyle(Color.customColor(.green))
                            
                            Text("Less Go 🥰")
                                .font(.customFont(.poppins, size: 13))
                                .foregroundStyle(Color.customColor(.gray))
                        case .limited:
                            Text("Allow Permission to access All Photos")
                                .font(.customFont(.poppins, size: 19))
                                .foregroundStyle(Color.customColor(.green))
                            
                            Text("No No Limited access won't work 😞")
                                .font(.customFont(.poppins, size: 13))
                                .foregroundStyle(Color.customColor(.gray))
                        @unknown default:
                            Text("Allow Permission to access All Photos")
                                .font(.customFont(.poppins, size: 19))
                                .foregroundStyle(Color.customColor(.green))
                            
                            Text("Something went wrong 😞")
                                .font(.customFont(.poppins, size: 13))
                                .foregroundStyle(Color.customColor(.gray))
                        }
                        
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                .offset(y: 50)
                Spacer()
            }

        }
    }
}

struct MarqueeCard: View {
    var icon: MarqueeIcon
    var body: some View {
        HStack(spacing: 8) {
            Image(icon.icon)
                .resizable()
                .frame(width: 50, height: 50)
            Text(icon.name)
                .foregroundStyle(.primary.opacity(0.8))
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.trailing, 4)
        }
    }
}

