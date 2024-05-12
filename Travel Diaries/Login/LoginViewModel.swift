//
//  LoginViewModel.swift
//  Travel Diaries
//
//  Created by Kailash on 30/04/24.
//

import SwiftUI
import FirebaseAuth
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    
    
    @Published var phoneNumber: String = ""
    @Published var userName: String = ""
    @Published var name: String = ""
    @Published var profilePictureUrl: URL? = nil
    @Published var gender: Genders = .male
    @Published var preferencesList: [String] = []
    @Published var travelQuestions: [MyTravelQuestions] = []
    
    @Published var currentProfileState: ProfileTravelOptions = .about
    
    
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var allUsers: [UserInfo] = []
    @Published private(set) var currentUser: UserInfo? = nil
    @Published private(set) var allUsersNames: [UserNames] = []
    @Published var allPosts: [PostsModel] = []
    @Published private(set) var userPosts: [PostsModel] = []
    
    @AppStorage("sessionPhoneNumber") var sessionPhoneNumber: String = ""
    
    
    func addDummyUsernames() async throws {
        try? await UserManager.shared.addDummyUserNames()
    }
    
    init() {
        getAllUserNames()
        getAllUsers()
        getAllPosts()
    }
    
    func getAllUserNames() {
        UserManager.shared.getAllUsernames()
            .sink { _ in
                
            } receiveValue: { [weak self] usernames in
                self?.allUsersNames = usernames
            }
            .store(in: &cancellables)
    }
    
    func updatePost(post: PostsModel) async throws {
        try? await UserManager.shared.updatePost(post: post)
    }
    
    func getAllUsers() {
        UserManager.shared.getAllUsers()
            .sink { _ in
                
            } receiveValue: { [weak self] userInfo in
                self?.allUsers = userInfo
                self?.getCurrentUser(phoneNumber: self?.sessionPhoneNumber ?? "")
                
            }
            .store(in: &cancellables)

    }
    
    func getCurrentUser(phoneNumber: String) {
        self.currentUser = self.allUsers.first(where: {$0.phoneNumber == phoneNumber})
    }
    
    func getAllPosts() {
        UserManager.shared.getAllPosts()
            .sink { _ in
                
            } receiveValue: {[weak self] posts in
                self?.allPosts = posts
                self?.getPostsByUser(phoneNumber: self?.sessionPhoneNumber ?? "")
            }
            .store(in: &cancellables)

    }
    
    func getPostsByUser(phoneNumber: String) {
        self.userPosts = self.allPosts.filter({ posts in
            posts.user.phoneNumber == sessionPhoneNumber
        })
        print("allPosts are \(self.allPosts)")
        print("userPosts are \(self.userPosts)")
    }
    
    func updateUser() async {
        Task {
            try? await UserManager.shared.updateUser(user: UserInfo(id: UUID(), phoneNumber: phoneNumber, userName: userName, name: name, profilePictureUrl: profilePictureUrl?.absoluteString, gender: gender, travelPreferences: preferencesList, travelQuestions: travelQuestions))
            try? await UserManager.shared.updateUserName(username: UserNames(userName: userName))
        }
    }
    
}

class AuthManager : ObservableObject {
    static let shared = AuthManager()
    private let auth = Auth.auth()
    @Published var currentUser: User? = Auth.auth().currentUser
    @Published var isLoggedIn: Bool = false
    
    @Published var isNumberActive: Bool = false
    @Published var isOTPActive: Bool = false
    
    private var verificationId: String?
    
    public func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
              Auth.auth().settings?.isAppVerificationDisabledForTesting = true
              guard let verificationId = verificationID, error == nil else {
                  print("my error is \(String(describing: error))")
                  completion(false)
                  return
              }
              self?.verificationId = verificationId
              completion(true)
          }
        
    }
    
    public func signOut() {
        try? Auth.auth().signOut()
        getLoginStatus()
        isLoggedIn = true
    }
    
    public func getLoginStatus() {
        if Auth.auth().currentUser == nil {
            print("Login Status = \(String(describing: Auth.auth().currentUser))")
            isLoggedIn = true
        } else {
            print("Login Status = \(String(describing: Auth.auth().currentUser))")
            isLoggedIn = false
        }
    }
    
    public func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        
        guard let verificationId = verificationId else {
           
            completion(false)
            return
        }
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationId,
          verificationCode: smsCode
        )
        
        Auth.auth().signIn(with: credential) {[weak self] authResult, error in
            guard authResult != nil, error == nil else {
                print("my error1 is \(String(describing: error))")
                completion(false)
                return
            }
            self?.isLoggedIn = true
            completion(true)
        }
    }
}
