//
//  LoginView.swift
//  ChatDemo
//
//  Created by Benji Loya on 24.12.2024.
//

import SwiftUI

struct LoginView: View {
  //  @StateObject var loginVM = LoginViewModel()
  //  @StateObject var registrationVM = RegistrationViewModel()
    /// View Properties
    @State private var emailAdress: String = ""
    @State private var password: String = ""
    @State private var resetPasswordButtonDisabled: Bool = false
    @State private var alreadyHavingAccount: Bool = true
    /// View's Height (Storing For Swipe Calculation)
    @State private var sheetScrollProgress: CGFloat = .zero
    /// Other Properties
    @State private var isKeyboardShowing: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
          //  Text(alreadyHavingAccount ? "Login" : "Registration")
           //     .font(.largeTitle.bold())
            
            HaskTextView(
                text: (alreadyHavingAccount ? "Login" : "Registration"),
                trigger: alreadyHavingAccount,
                transition: .identity,
                speed: 0.05
            )
            .font(.largeTitle.bold())
            
            if alreadyHavingAccount {
                /// Login
               // CustomTF(hint: "Email Adress", text: $loginVM.email, icon: "envelope")
                
                TextField("Password", text: $emailAdress)
                    .padding(10)
                
              //  CustomTF(hint: "*****", text: $loginVM.password, icon: "lock", isPassword: true)
                TextField("Password", text: $password)
                    .padding(10)
                
                Button {
                    // по-хорошему надо будет добавить проверку на "@", но сделаю позже
                    /*
                    if loginVM.email.isEmpty {
                        Toast.shared.present(
                            title: "Please enter your email",
                            symbol: "exclamationmark.triangle",
                            isUserInteractionEnabled: true,
                            timing: .medium
                        )
                        return
                    }
                    
                    // установка блокировки кнопки, чтоб ее не нажимали 10 раз
                    resetPasswordButtonDisabled = true
                    
                    Task {
                        do {
                            try await loginVM.resetPassword()
                            print("Password reset!")
                        } catch {
                            print(error)
                        }
                    }
                    */
                    Toast.shared.present(
                        title: "Password has been reset",
                        symbol: "lock.open",
                        isUserInteractionEnabled: true,
                        timing: .medium
                    )
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        Toast.shared.present(
                            title: "Please check your email",
                            symbol: "email",
                            isUserInteractionEnabled: true,
                            timing: .medium
                        )
                    }
                    
                    
                } label: {
                    Text("Reset Password")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray.opacity(resetPasswordButtonDisabled ? 0.4 : 0.7))
                        .padding(10)
                        .background(Color.black.opacity(0.001))
                }
                .disabled(resetPasswordButtonDisabled)
                
            } else {
                /// Registration
             //   CustomTF(hint: "Username", text: $registrationVM.username, icon: "person")
                TextField("Password", text: $emailAdress)
                    .padding(10)
                
             //   CustomTF(hint: "Email Adress", text: $registrationVM.email, icon: "envelope")
                TextField("Password", text: $emailAdress)
                    .padding(10)
                
             //   CustomTF(hint: "*****", text: $registrationVM.password, icon: "lock", isPassword: true)
                TextField("Password", text: $emailAdress)
                    .padding(10)
            }
            
            /*
            CustomLoginButton(
                buttonTint: AnyShapeStyle(
                    LinearGradient(
                        colors: [.red, .orange],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            ) {
                HStack(spacing: 8) {
                    Text(alreadyHavingAccount ? "Login" : "Get Starting")
                    
                    Image(systemName: "arrow.right")
                }
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 120 + (sheetScrollProgress * (alreadyHavingAccount ? 0 : 50)))
                .opacity(sheetScrollProgress)
            //    .opacity(registrationVM.isAuthenticating || loginVM.isAuthenticating ? 0 : 1)
                .overlay {
                    if registrationVM.isAuthenticating || loginVM.isAuthenticating {
                        ProgressView()
                            .tint(Color.theme.primaryBackground)
                    }
                }
            } action: {
                    if alreadyHavingAccount {
                        // Логин
                        do {
                            try await loginVM.login()
                            return .success
                        } catch {
                            return .failed("\(error.localizedDescription)")
                        }
                    } else {
//                         Регистрация
                        do {
                            try await registrationVM.createUser()
                            return .success
                        } catch {
                            return .failed("\(error.localizedDescription)")
                        }
                    }
                
            }
            .buttonStyle(.opacityLess)
//             Disable button when form is not valid and the button is in the Login or Get Started state
            .disabled(!(alreadyHavingAccount ? loginVM.formIsValid : registrationVM.formIsValid))
            .opacity((alreadyHavingAccount ? loginVM.formIsValid : registrationVM.formIsValid) ? 1 : 0.7)
            .padding(.leading, 100)
            */
            
            Spacer(minLength: 150)
            
        }
        .padding(15)
        .padding(.horizontal, 10)
        .padding(.top, 15)
     //   .padding(.bottom, 220)
        .overlay(alignment: .bottom, content: {
            HStack(spacing: 4) {
             //   Text(alreadyHavingAccount ? "Don't have an account?" : "Already having an account?")
               //     .foregroundStyle(.gray)
                
                HaskTextView(
                    text: (alreadyHavingAccount ? "Don't have an account?" : "Already having an account?"),
                    trigger: alreadyHavingAccount,
                    transition: .interpolate,
                    speed: 0.1
                )
                .foregroundStyle(.gray)
                
                Button {
                    withAnimation(.snappy) {
                        alreadyHavingAccount.toggle()
                    }
                } label: {
                 //   Text(alreadyHavingAccount ? "Create an account" : "Login")
                    HaskTextView(
                        text: (alreadyHavingAccount ? "Create an account" : "Login"),
                        trigger: alreadyHavingAccount,
                        transition: .interpolate,
                        speed: 0.1
                    )
                        .tint(Color.primary)
                }
            }
            .font(.callout)
            .textScale(.secondary)
            .transition(.scale)
            
            /*
            /// Other Login/SignUp View
            VStack(spacing: 15) {
                Group {
                    if alreadyHavingAccount {
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .foregroundStyle(.gray)
                            
                            Button("Create an account") {
                                withAnimation(.snappy) {
                                    alreadyHavingAccount.toggle()
                                }
                            }
//                            .tint(Color.theme.darkWhite)
                        }
                     //   .transition(.push(from: .bottom))
                    } else {
                        HStack(spacing: 4) {
                            Text("Already having an account?")
                                .foregroundStyle(.gray)
                            
                            Button("Login") {
                                withAnimation(.snappy) {
                                    alreadyHavingAccount.toggle()
                                }
                            }
                      //      .tint(Color.theme.darkWhite)
                        }
                      //  .transition(.push(from: .top))
                    }
                }
                .font(.callout)
                .textScale(.secondary)
                
            }
            */
            .frame(maxWidth: .infinity)
            .padding(.bottom, 15)
            .padding(.horizontal, 10)
            .multilineTextAlignment(.center)
            
        })
    }
}

#Preview {
    LoginView()
}
