//
//  ContentViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 11.08.2023.
//

//import Foundation
//import Combine
//import FirebaseAuth
//
//class ContentViewModel: ObservableObject {
//    @Published var user: User?
//    @Published var userSession: FirebaseAuth.User?
//    
//    private var cancellables = Set<AnyCancellable>()
//    
//    init() {
//        setupSubscribers()
//    }
//    
//    private func setupSubscribers() {
//        UserService.shared.$currentUser.sink { [weak self] user in
//            self?.user = user
//        }.store(in: &cancellables)
//        
//        AuthService.shared.$userSession.sink { [weak self] session in
//            self?.userSession = session
//        }.store(in: &cancellables)
//    }
//}

import Foundation
import Combine
import FirebaseAuth

class ContentViewModel: ObservableObject {
    @Published var user: User?
    @Published var userSession: FirebaseAuth.User?

    private var cancellables = Set<AnyCancellable>()
    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol = DIContainer.shared.authService) {
        self.authService = authService
        setupSubscribers()
    }

    private func setupSubscribers() {
        UserService.shared.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)

        authService.userSessionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] session in
                self?.userSession = session
            }
            .store(in: &cancellables)
    }

}




// PROMPT
/*
 
 вот моя вью модель
 import Foundation
 import Combine
 import FirebaseAuth

 class ContentViewModel: ObservableObject {
     @Published var user: User?
     @Published var userSession: FirebaseAuth.User?

     private var cancellables = Set<AnyCancellable>()

     init() {
         setupSubscribers()
     }

     private func setupSubscribers() {
         UserService.shared.$currentUser.sink { [weak self] user in
             self?.user = user
         }.store(in: &cancellables)

         AuthService.shared.$userSession.sink { [weak self] session in
             self?.userSession = session
         }.store(in: &cancellables)
     }
 }
  в ней ошибка Type 'AuthService' has no member 'shared' она возникла потомучто я избавился в AuthService сервисе от синглтона и внедрил протоколы , как мне исправить эту ошибку во вью модели? надо передать в нее AuthService как то по другому.
 
 вот мой новый
 import Foundation
 import Firebase
 import FirebaseFirestoreSwift
 import FirebaseAuth

 class AuthService: AuthServiceProtocol, ObservableObject {
     private let provider: AuthProviderProtocol
     
     init(provider: AuthProviderProtocol) {
         self.provider = provider
     }
     
     var userSession: FirebaseAuth.User? {
         return provider.userSession
     }
     
     func login(withEmail email: String, password: String) async throws {
         try await provider.signIn(email: email, password: password)
     }
     
     func createUser(withEmail email: String, password: String, username: String, fullname: String?) async throws {
         try await provider.createUser(email: email, password: password, username: username, fullname: fullname)
     }
     
     func signOut() async throws {
         try await provider.signOut()
     }
     
     func deleteUser() async throws {
         try await provider.deleteUser()
     }
 }


 class EmailAuthProvider: AuthProviderProtocol {
     @Published var userSession: FirebaseAuth.User?
     
     init() {
         self.userSession = Auth.auth().currentUser
     }
     
     func signIn(email: String, password: String) async throws {
         let result = try await Auth.auth().signIn(withEmail: email, password: password)
         self.userSession = result.user
     }
     
     func createUser(email: String, password: String, username: String, fullname: String?) async throws {
         let result = try await Auth.auth().createUser(withEmail: email, password: password)
         self.userSession = result.user
         
         // Сохранение дополнительной информации о пользователе
         let user = result.user
         try await saveUserData(userId: user.uid, email: email, username: username, fullname: fullname)
     }

     private func saveUserData(userId: String, email: String, username: String, fullname: String?) async throws {
         let user = User(
             username: username,
             fullname: fullname ?? "", // `fullname` опционален
             email: email,
             profileImageUrl: nil
         )
         guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
         try await FirestoreConstants.UsersCollection.document(userId).setData(encodedUser)
     }

     func signOut() async throws {
         try Auth.auth().signOut()
         self.userSession = nil
     }
     
     func deleteUser() async throws {
         guard let currentUser = Auth.auth().currentUser else { return }
         try await currentUser.delete()
         self.userSession = nil
     }
 }

 и вот так я передаю его в другие вью модели (это тебе как пример)
 class LoginViewModel: ObservableObject {
     @Published var email = ""
     @Published var password = ""
     @Published var isAuthenticating = false
     @Published var showAlert = false
     @Published var authError: AuthError?
     
     private let authService: AuthServiceProtocol

     init(authService: AuthServiceProtocol = DIContainer.shared.authService) {
         self.authService = authService
     }
     
     @MainActor
     func login() async throws {
         isAuthenticating = true
         
         do {
             try await authService.login(withEmail: email, password: password)
             isAuthenticating = false
         } catch {
             let authError = AuthErrorCode.Code(rawValue: (error as NSError).code)
             self.showAlert = true
             isAuthenticating = false
             self.authError = AuthError(authErrorCode: authError ?? .userNotFound)
         }
     }
 }

 class RegistrationViewModel: ObservableObject {
     @Published var email = ""
     @Published var password = ""
     @Published var username = ""
     @Published var fullname = ""
     @Published var showAlert = false
     @Published var authError: AuthError?
     @Published var isAuthenticating = false
     
     private let authService: AuthServiceProtocol

     init(authService: AuthServiceProtocol = DIContainer.shared.authService) {
         self.authService = authService
     }
     
     @MainActor
     func createUser() async throws {
         isAuthenticating = true
         do {
             try await authService.createUser(
                 withEmail: email,
                 password: password,
                 username: username,
                 fullname: fullname
             )
             isAuthenticating = false
         } catch {
             let authErrorCode = AuthErrorCode.Code(rawValue: (error as NSError).code)
             showAlert = true
             isAuthenticating = false
             authError = AuthError(authErrorCode: authErrorCode ?? .userNotFound)
         }
     }
 }
 
 и вот еще протокол на всякий случай
 protocol AuthServiceProtocol {
     var userSession: FirebaseAuth.User? { get }

     func login(withEmail email: String, password: String) async throws
     func createUser(withEmail email: String, password: String, username: String, fullname: String?) async throws
     func signOut() async throws
     func deleteUser() async throws
 }

 protocol AuthenticationFormProtocol {
     var formIsValid: Bool { get }
 }

 protocol AuthProviderProtocol {
     var userSession: FirebaseAuth.User? { get }
     
     func signIn(email: String, password: String) async throws
     func createUser(email: String, password: String, username: String, fullname: String?) async throws
     func signOut() async throws
     func deleteUser() async throws
 }

 enum AuthProviderType {
     case email
     case google
     case apple
 }

 class AuthProviderFactory {
     static func createProvider(type: AuthProviderType) -> AuthProviderProtocol {
         switch type {
         case .email:
             return EmailAuthProvider()
         case .google:
             fatalError("GoogleAuthProvider not implemented")
         case .apple:
             fatalError("AppleAuthProvider not implemented")
         }
     }
 }

 class DIContainer {
     
     static let shared = DIContainer()
     
     private init() { }
     
     lazy var inboxService: InboxServiceProtocol = InboxService.shared
     lazy var messageService: MessageServiceProtocol = MessageService()
     lazy var userService: UserServiceProtocol = UserService.shared
     
     // Фабрика для создания экземпляра ChatService с указанным партнером
     func createChatService(chatPartner: User) -> ChatServiceProtocol {
         return ChatService(chatPartner: chatPartner)
     }
     
     private let authProviderType: AuthProviderType = .email

        lazy var authService: AuthServiceProtocol = {
            let provider = AuthProviderFactory.createProvider(type: authProviderType)
            return AuthService(provider: provider)
        }()
 }
 
 и так - мне надо изменить вью модель ContentViewModel правильно предав туда AuthService и желательно не меняя код в остальных местах
 */
