//
//  GenderCard.swift
//  Travel Diaries
//
//  Created by Kailash on 07/05/24.
//

import SwiftUI

struct GenderCard: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    var onCLick: () -> Void
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                CustomCheckbox(isChecked: loginViewModel.gender == .male, text: Genders.male.rawValue, image: "male-symbol") {
                    loginViewModel.gender = .male
                }
                Spacer()
                CustomCheckbox(isChecked: loginViewModel.gender == .female, text: Genders.female.rawValue, image: "female-symbol") {
                    loginViewModel.gender = .female
                }
                Spacer()
            }
            Spacer()
            CustomCheckbox(isChecked: loginViewModel.gender == .other, text: Genders.male.rawValue, image: "other-symbol") {
                loginViewModel.gender = .other
            }
            Spacer()
            Button {
                onCLick()
            } label: {
                Text("Ahh Proceed Now ☠️")
                    .font(.customFont(.poppins, size: 20))
                    .foregroundStyle(Color.customColor(.white))
                    .padding()
                    .frame(width: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.customColor(.green))
                    }
            }
            Spacer()
            
        }
        
    }
}

struct CustomCheckbox: View {
    
    var isChecked: Bool
    let text: String
    let image: String
    var onClick: () -> Void
    
    var body: some View {
        VStack(spacing: 6) {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .frame(width: 100, height: 100)
                .foregroundColor(Color.customColor(isChecked ? .green : .gray))
            
                Text(text)
                    .foregroundColor(Color.customColor(isChecked ? .green : .gray))
                    .font(.customFont(.poppins, size: 20))
                    .padding(.leading, 5)
                
        }
        .padding(.all, 10)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10, style: .circular)
                .stroke(Color.customColor(.green).opacity(0.4))
        })
        .onTapGesture {
            onClick()
        }
        .padding()
    }
}

