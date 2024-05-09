//
//  TravelQuestions.swift
//  Travel Diaries
//
//  Created by Kailash on 09/05/24.
//

import SwiftUI

struct TravelQuestionsView: View {
    
    var onClick:() -> Void
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @State var question1: String = ""
    @State var question2: String = ""
    @State var question3: String = ""
    
    @State var answer1: String = ""
    @State var answer2: String = ""
    @State var answer3: String = ""
    
    @FocusState var isKeyBoardActive
    @FocusState var isKeyBoardActive2
    @FocusState var isKeyBoardActive3
    
    let characterLimit = 100
    
    @State var isQuestionsViewOpen: Bool = false
    @State var currentQuestion: currentQuestion = .first
    
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack {
                        Button {
                            currentQuestion = .first
                            isQuestionsViewOpen.toggle()
                        } label: {
                            Text(question1 == "" ? "Pick Question 1" : question1)
                                .font(.customFont(.poppins, size: 14))
                                .foregroundStyle(Color.customColor(.yellow))
                                .padding()
                        }
                        
                        ZStack(alignment: .topLeading) {
                                TextEditor(text: $answer1)
                                    .lineSpacing(15)
                                    .submitLabel(.go)
                                    .keyboardType(.webSearch)
                                    .focused($isKeyBoardActive)
                                    .onSubmit {
                                        withAnimation {
                                            isKeyBoardActive = false
                                            isKeyBoardActive3 = false
                                            isKeyBoardActive2 = true
                                        }
                                    }
                                    .font(.customFont(.poppins, size: 14))
                                    .keyboardType(.numberPad)
                                    .foregroundStyle(Color.customColor(.white))
                                    .padding()
                                    .background(.black.opacity(0.6))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.customColor(.green).opacity(0.5))
                                    }
                                    .frame(height: 150)
                                    
                            
                            if answer1.isEmpty && isKeyBoardActive == false {
                                VStack(alignment: .leading) {
                                    Text("Umm what's the answer ??")
                                        .font(.customFont(.poppins, size: 14))
                                        .foregroundStyle(Color.customColor(.yellow))
                                        .padding(.trailing)
                                        .lineSpacing(15)
                                    
                                }
                                .padding()
                            }
                            
                            VStack(alignment: .trailing) {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text(" \(answer1.count) / 100")
                                        .font(.customFont(.poppins, size: 14))
                                        .foregroundStyle(Color.customColor(.yellow))
                                        .padding(.trailing)
                                        .lineSpacing(15)
                                }
                                
                            }
                            .padding()
                        }
                        .onChange(of: answer1, { oldValue, newValue in
                            if newValue.count > characterLimit {
                                answer1 = String(newValue.prefix(characterLimit))
                            }
                        })
                        .padding()
                    }
                    .padding()
                    
                    VStack {
                        Button {
                            currentQuestion = .second
                            isQuestionsViewOpen.toggle()
                        } label: {
                            Text(question2 == "" ? "Pick Question 2" : question2)
                                .font(.customFont(.poppins, size: 14))
                                .foregroundStyle(Color.customColor(.yellow))
                                .padding()
                        }
                        
                        ZStack(alignment: .topLeading) {
                                TextEditor(text: $answer2)
                                    .lineSpacing(15)
                                    .submitLabel(.go)
                                    .keyboardType(.webSearch)
                                    .focused($isKeyBoardActive2)
                                    .onSubmit {
                                        withAnimation {
                                            isKeyBoardActive = false
                                            isKeyBoardActive2 = false
                                            isKeyBoardActive3 = true
                                        }
                                    }
                                    .font(.customFont(.poppins, size: 14))
                                    .keyboardType(.numberPad)
                                    .foregroundStyle(Color.customColor(.white))
                                    .padding()
                                    .background(.black.opacity(0.6))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.customColor(.green).opacity(0.5))
                                    }
                                    .frame(height: 150)
                                    
                            
                            if answer2.isEmpty && isKeyBoardActive2 == false {
                                VStack(alignment: .leading) {
                                    Text("Go Ahead & answer this")
                                        .font(.customFont(.poppins, size: 14))
                                        .foregroundStyle(Color.customColor(.yellow))
                                        .padding(.trailing)
                                        .lineSpacing(15)
                                    
                                }
                                .padding()
                            }
                            
                            VStack(alignment: .trailing) {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text(" \(answer2.count) / 100")
                                        .font(.customFont(.poppins, size: 14))
                                        .foregroundStyle(Color.customColor(.yellow))
                                        .padding(.trailing)
                                        .lineSpacing(15)
                                }
                                
                            }
                            .padding()
                        }
                        .onChange(of: answer2, { oldValue, newValue in
                            if newValue.count > characterLimit {
                                answer2 = String(newValue.prefix(characterLimit))
                            }
                        })
                        .padding()
                    }
                    .padding()
                    
                    VStack {
                        Button {
                            currentQuestion = .third
                            isQuestionsViewOpen.toggle()
                        } label: {
                            Text(question3 == "" ? "Pick Question 3" : question3)
                                .font(.customFont(.poppins, size: 14))
                                .foregroundStyle(Color.customColor(.yellow))
                                .padding()
                        }
                        
                        ZStack(alignment: .topLeading) {
                                TextEditor(text: $answer3)
                                    .lineSpacing(15)
                                    .submitLabel(.go)
                                    .keyboardType(.webSearch)
                                    .focused($isKeyBoardActive3)
                                    .onSubmit {
                                        withAnimation {
                                            isKeyBoardActive = false
                                            isKeyBoardActive3 = false
                                            isKeyBoardActive2 = false
                                        }
                                    }
                                    .font(.customFont(.poppins, size: 14))
                                    .keyboardType(.numberPad)
                                    .foregroundStyle(Color.customColor(.white))
                                    .padding()
                                    .background(.black.opacity(0.6))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.customColor(.green).opacity(0.5))
                                    }
                                    .frame(height: 150)
                                    
                            
                            if answer3.isEmpty && isKeyBoardActive3 == false {
                                VStack(alignment: .leading) {
                                    Text("Last one we promise 🙂")
                                        .font(.customFont(.poppins, size: 14))
                                        .foregroundStyle(Color.customColor(.yellow))
                                        .padding(.trailing)
                                        .lineSpacing(15)
                                    
                                }
                                .padding()
                            }
                            
                            VStack(alignment: .trailing) {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text(" \(answer3.count) / 100")
                                        .font(.customFont(.poppins, size: 14))
                                        .foregroundStyle(Color.customColor(.yellow))
                                        .padding(.trailing)
                                        .lineSpacing(15)
                                }
                                
                            }
                            .padding()
                        }
                        .onChange(of: answer3, { oldValue, newValue in
                            if newValue.count > characterLimit {
                                answer3 = String(newValue.prefix(characterLimit))
                            }
                        })
                        .padding()
                    }
                    .padding()
                    .padding(.bottom, 60)
                }
            }
            .frame(maxHeight: UIScreen.main.bounds.height - 300, alignment: .top)
            
            
            VStack {
                
                Spacer()
                
                Button {
                    if answer1 != "" && answer2 != "" && answer3 != "" && question1 != "" && question2 != "" && question3 != "" {
                        loginViewModel.travelQuestions.append(MyTravelQuestions(question: question1, answer: answer1))
                        loginViewModel.travelQuestions.append(MyTravelQuestions(question: question2, answer: answer2))
                        loginViewModel.travelQuestions.append(MyTravelQuestions(question: question3, answer: answer3))
                        onClick()
                    }
                } label: {
                    Text("Was this last 🥺")
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
                .padding(.bottom, 10)
            }
            VStack {
                Text("Answer Some Questions")
                    .foregroundStyle(Color.customColor(.green))
                    .font(.customFont(.poppins, size: 18))
                    .padding(.top, 20)
                Spacer()
            }
        }
        .sheet(isPresented: $isQuestionsViewOpen, content: {
            switch currentQuestion {
            case .first:
                QuestionsView(selectedQuestion: $question1, isSelectedQuestion: $isQuestionsViewOpen)
                    .presentationDetents([.medium])
            case .second:
                QuestionsView(selectedQuestion: $question2, isSelectedQuestion: $isQuestionsViewOpen)
                    .presentationDetents([.medium])
            case .third:
                QuestionsView(selectedQuestion: $question3, isSelectedQuestion: $isQuestionsViewOpen)
                    .presentationDetents([.medium])
            }
        })
    }
}

enum currentQuestion {
    case first, second, third
}

import SwiftUI

struct QuestionsView: View {
    
    @Binding var selectedQuestion: String
    @Binding var isSelectedQuestion: Bool
    
    let travelQuestions = TravelQuestions()
    @State var travelQuestion: Any? = nil
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(QuestionType.allCases, id: \.self) { type in
                    Button(action: {
                        switch type {
                        case .aboutMe:
                            travelQuestion = TravelQuestions.AboutMeSection.self
                        case .storyTime:
                            travelQuestion = TravelQuestions.StoryTimeSection.self
                        case .bucketList:
                            travelQuestion = TravelQuestions.BucketListSection.self
                        case .favorites:
                            travelQuestion = TravelQuestions.FavoritesSection.self
                        }
                        print("Tapped \(type.rawValue)")
                    }) {
                        Text(type.rawValue)
                            .foregroundColor(.white)
                            .padding()
                            .background(travelQuestion.debugDescription == type.rawValue ? Color.customColor(.blue) : Color.customColor(.green).opacity(0.5))
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
            .padding(.top)
        }
        .frame(height: 60)
        
        ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(TravelQuestions.questions(for: travelQuestion.self ?? TravelQuestions.AboutMeSection.self), id: \.self) { question in
                        Button {
                            selectedQuestion = question.description
                            isSelectedQuestion = false
                        } label: {
                            Text(question.description)
                                .padding(.horizontal)
                                .font(.customFont(.poppins, size: 15))
                        }
                    }
                .padding(.vertical)
            }
        }
    }
}

enum QuestionType: String, CaseIterable {
    case aboutMe = "About Me"
    case storyTime = "Story Time"
    case bucketList = "Bucket List"
    case favorites = "Favorites"
}

//#Preview {
//    TravelQuestionsView()
//}
