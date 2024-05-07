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
final class LoginViewModel: ObservableObject {
    
    
    @Published var phoneNumber: String = ""
    @Published var userName: String = ""
    @Published var profilePictureUrl: String = ""
    
    
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var allUsers: [UserInfo] = []
    @Published private(set) var allUsersNames: [UserNames] = []
    
    func addDummyUsernames() async throws {
        try? await UserManager.shared.addDummyUserNames()
    }
    
    init() {
        getAllUserNames()
        getAllUsers()
    }
    
    func getAllUserNames() {
        UserManager.shared.getAllUsernames()
            .sink { _ in
                
            } receiveValue: { [weak self] usernames in
                self?.allUsersNames = usernames
            }
            .store(in: &cancellables)
    }
    
    func getAllUsers() {
        UserManager.shared.getAllUsers()
            .sink { _ in
                
            } receiveValue: { [weak self] userInfo in
                self?.allUsers = userInfo
            }
            .store(in: &cancellables)

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
            print("Login Status = \(Auth.auth().currentUser)")
            isLoggedIn = true
        } else {
            print("Login Status = \(Auth.auth().currentUser)")
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
