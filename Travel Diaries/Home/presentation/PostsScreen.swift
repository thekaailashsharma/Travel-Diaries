//
//  SlackAnimation.swift
//  Digital Greeting Card
//
//  Created by Admin on 05/03/24.
//

import SwiftUI
import Foundation
import SwiftUI

func initNavigation(navBarAppearence: UINavigationBarAppearance, bgColor: UIColor, fgColor: UIColor) {
    navBarAppearence.configureWithOpaqueBackground()
    navBarAppearence.backgroundColor = UIColor.init(Color(uiColor: bgColor))
    
    navBarAppearence.titleTextAttributes = [
        .foregroundColor: UIColor.init(Color(uiColor: fgColor))
    ]
    navBarAppearence.largeTitleTextAttributes = [
        .foregroundColor : UIColor.init(Color(uiColor: fgColor))
    ]
        
    UINavigationBar.appearance().standardAppearance = navBarAppearence
    UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearence
}

let messages: [Messages] = [
    Messages(image: "img 1", name: "John Doe", message: "Hey everyone! I just found this amazing tutorial on [SwiftUI Animations](https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-animations-to-create-smooth-transitions-in-swiftui). It's super helpful if you want to level up your SwiftUI skills.", time: Date()),
    
    Messages(image: "img2", name: "Jane Smith", message: "Hi folks! Check out this awesome library for creating beautiful charts in SwiftUI: [SwiftUICharts](https://github.com/AppPear/ChartView). It's really easy to use and customizable.", time: Date().addingTimeInterval(-120)),
    
    Messages(image: "img3", name: "Mike Johnson", message: "Hello SwiftUI enthusiasts! Want to learn about building complex layouts? Here's a great article on [SwiftUI Grids](https://www.bigmountainstudio.com/blog/swiftui-grids). It provides a comprehensive guide with examples.", time: Date().addingTimeInterval(-300)),
    
    Messages(image: "img4", name: "Emily Brown", message: "Hey everyone! I stumbled upon this fantastic resource for mastering navigation in SwiftUI: [SwiftUI Navigation Tutorial](https://www.appcoda.com/swiftui-navigation/). It covers everything from basic navigation to advanced techniques.", time: Date().addingTimeInterval(-600)),
    
    Messages(image: "img5", name: "David Wilson", message: "Hi all! If you're interested in incorporating gestures into your SwiftUI app, here's a helpful guide: [Gesture Recognition in SwiftUI](https://swiftwithmajid.com/2020/01/29/gesture-recognition-in-swiftui/). It's a must-read for SwiftUI developers.", time: Date().addingTimeInterval(-900))
]

struct PostsScreen: View {
    
    @State var offset: CGSize = .zero
    @State var isSent: Bool = false
    @State var isSent2: Bool = false
    
    @State var users = [
        Userlist(id: 0, username: "Olivia"),
        Userlist(id: 1, username: "Emma"),
        Userlist(id: 2, username: "Ava"),
        Userlist(id: 3, username: "Charlotte"),
        Userlist(id: 4, username: "Sophia"),
        Userlist(id: 5, username: "Amelia")
    ]
    
    let navBarAppearence = UINavigationBarAppearance()
    
    init() {
        initNavigation(navBarAppearence: navBarAppearence, bgColor: .black, fgColor: .white)
    }
    
    var body: some View {
        
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                
                VStack {
                    
                    
                    ZStack {
                        
                        if !isSent {
                            ForEach(users) { rs in
                                CardsView(viewdata: rs) {
                                    users.removeAll { $0.id == rs.id}
                                }
                                .stacked(at: users.firstIndex(of: rs) ?? 0, in: users.count)
                            }
                        }
                        
                        SentConfirm(
                            isSent: $isSent
                        )
                        .scaleEffect(isSent ? 1.2: 0.3)
                        .opacity(isSent ? 1 : 0)
                        
                        
                        
                        MyLottieAnimation(url: Bundle.main.url(
                            forResource: "confetti",
                            withExtension: "lottie")!,loopMode: .repeat(2)
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .scaleEffect(isSent ? 2.0 : 0.3)
                        .opacity(isSent ? 1 : 0)
                        
                    }
                    Spacer()
                    
                    if !isSent {
                        HStack {
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("Keep Unread")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            .buttonStyle(.plain)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.customColor(.gray))
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("Mark as Read")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            .buttonStyle(.plain)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.customColor(.gray))
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                            Spacer()
                            
                        }
                        .transition(.move(edge: .bottom))
                        .padding()
                    }
                    
                }
            }
            .onChange(of: users) { value in
                self.users = value
                if value.count == 0 {
                    withAnimation {
                        isSent = true
                        DispatchQueue.main.asyncAfter(
                            deadline: .now() + 0.5) {
                                isSent2 = true
                            
                        }
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "arrowshape.turn.up.backward")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(Color("navTitle").gradient)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("Undo")
                        .foregroundColor(.white)
                }
            }
            .navigationTitle("\(users.count) left")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(isSent)
            
        }
    
    
}

struct SlackAnimation_Previews: PreviewProvider {
    static var previews: some View {
        PostsScreen()
    }
}

struct Userlist: Identifiable, Equatable {
    
    let id: Int
    let username: String
}



struct CardsView: View {
    
    @State private var offset = CGSize.zero
    @State private var color: Color = .black
    @State var viewdata: Userlist
    var onDelete: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(
                    width: UIScreen.main.bounds.width - 50,
                    height: UIScreen.main.bounds.height - 250
                )
                .border(Color.customColor(.gray), width: 1.0)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .foregroundColor(color.opacity(0.9))
                .shadow(radius: 4)
                .overlay {
                    if color == .black {
                        ScrollView {
                            LazyVStack {
                                VStack {
                                    HStack {
                                        Text("#swift-ui")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                        
                                        Image(systemName: "chevron.down")
                                            .font(.caption)
                                    }
                                    .padding()
                                    .foregroundColor(.white)
                                    
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color.customColor(.gray).opacity(0.9))
                                }
                                
                                ForEach(messages) { message in
                                    MessageView(message: message)
                                }
                                
                                Spacer()
                            }
                        }
                    } else if color == .green {
                        ZStack(alignment: .topLeading) {
                            Color.customColor(.green)
                                .opacity(color != Color.black ? 0.5 : 1)
                            
                            HStack() {
                                VStack(alignment: .listRowSeparatorLeading) {
                                    Image(systemName: "checkmark")
                                        .padding()
                                        .clipShape(Circle())
                                    
                                    
                                    Text("Mark as")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    
                                    Text("Read")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                }
                                
                                
                                Spacer()
                            }
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .padding(.horizontal, 50)
                            .padding(.vertical, 50)
                            
                            Spacer()
                            
                            
                        }
                    }
                    
                    else if color == .red {
                        ZStack(alignment: .topLeading) {
                            Color(uiColor: .red)
                                .opacity(color != Color.black ? 0.5 : 1)
                            
                            HStack() {
                                Spacer()
                                VStack(alignment: .listRowSeparatorLeading) {
                                    Image(systemName: "eyebrow")
                                        .padding()
                                        .clipShape(Circle())
                                    
                                    
                                    Text("Keep")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    
                                    Text("Unread")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                }
                                
                                
                                
                            }
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .padding(.horizontal, 50)
                            .padding(.vertical, 50)
                            
                            Spacer()
                            
                            
                        }
                    }
                    
                    
                }
            
        }
        .scaleEffect(getScale())
        .rotationEffect(.degrees(getRotation()))
        .offset(x: offset.width * 1, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation {
                        changeColor(width: offset.width)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        swipeCard(width: offset.width)
                        changeColor(width: offset.width)
                    }
                }
        )
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
            onDelete()
        case 150...500:
            offset = CGSize(width: 500, height: 0)
            onDelete()
        default:
            offset = .zero
        }
    }
    
    func changeColor(width: CGFloat) {
        switch width {
        case -500...(-130):
            color = .red
        case 130...500:
            color = .green
        default:
            color = .black
        }
    }
    
    func getScale() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let offset = abs(offset.width)
        let percent = offset / max
        return 1.0 + min(percent, 0.2) * 0.2
    }
    
    func getRotation() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let offset = offset.width
        let percent = Double(offset / max)
        let maxAngle: Double = 10
        return percent * maxAngle
    }
    
    
}

struct Messages : Identifiable {
    let id: UUID = .init()
    let image: String
    let name: String
    let message: LocalizedStringKey
    let time: Date
}

struct MessageView: View {
    
    var message: Messages
    
    var body: some View {
        
        HStack(alignment: .top) {
            Image(message.image)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                HStack {
                    Text(message.name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text(message.time, style: .time)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.customColor(.gray))
                }
                .padding(.bottom, 5)
                
                
                Text(message.message)
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                HStack {
                    Text("🔥 \(Int.random(in: 1...100))")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.all, 8)
                        .background(Color.customColor(.gray))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text("👏 \(Int.random(in: 1...100))")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.all, 8)
                        .background(Color.customColor(.gray))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text("🚀 \(Int.random(in: 1...100))")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.all, 8)
                        .background(Color.customColor(.gray))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
            Spacer()
            
        }
        .padding()
        
    }
}
struct SentConfirm: View {
    
    @Binding var isSent : Bool
    var blue = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle")
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(Color(uiColor: blue).gradient)
                .frame(width: 100, height: 100)
                .padding(.bottom)
            
            Text("Sent Successfully")
                .font(.headline)
                .foregroundColor(.blue)
                .bold()
        }
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: offset * 0.5,y: offset * 1.5)
    }
}
