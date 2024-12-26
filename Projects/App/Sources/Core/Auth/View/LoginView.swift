//
//  LoginView.swift
//  ChatDemo
//
//  Created by Benji Loya on 24.12.2024.
//

import SwiftUI
import Components

struct LoginView: View {
    @StateObject var loginVM = LoginViewModel()
    @StateObject var registrationVM = RegistrationViewModel()
    /// View Properties
    @State private var emailAdress: String = ""
    @State private var password: String = ""
    @State private var resetPasswordButtonDisabled: Bool = false
    @State private var alreadyHavingAccount: Bool = true
    /// View's Height (Storing For Swipe Calculation)
    @State private var sheetScrollProgress: CGFloat = .zero
    /// Other Properties
    @State private var isKeyboardShowing: Bool = false
    @Binding var showLoginSheet: Bool
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HaskTextView(
                text: (alreadyHavingAccount ? "Login" : "Sign Up"),
                trigger: alreadyHavingAccount,
                transition: .identity,
                speed: 0.05
            )
            .font(.largeTitle.bold())
            .padding(.leading, 10)
            
            if alreadyHavingAccount {
                /// Login
                CustomTF(hint: "Email Adress", text: $loginVM.email, icon: "envelope")
                    .padding(10)
                
                CustomTF(hint: "*****", text: $loginVM.password, icon: "lock", isPassword: true)
                    .padding(10)
                
                Button {
                    // по-хорошему надо будет добавить проверку на "@", но сделаю позже
                    
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
                CustomTF(hint: "Username", text: $registrationVM.username, icon: "person")
                    .padding(10)
                
                CustomTF(hint: "Email Adress", text: $registrationVM.email, icon: "envelope")
                    .padding(10)
                
                CustomTF(hint: "*****", text: $registrationVM.password, icon: "lock", isPassword: true)
                    .padding(10)
            }
            
            HStack {
                Spacer()
                
                CustomLoginButton(
                    buttonTint: AnyShapeStyle(
                        LinearGradient(
                            colors: [.red, .orange],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                ) {
                    HStack(spacing: 15) {
                        Text(alreadyHavingAccount ? "Login" : "Get Starting")
                        
                        Image(systemName: "arrow.right")
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 150 + (sheetScrollProgress * (alreadyHavingAccount ? 0 : 50)))
                    .opacity(registrationVM.isAuthenticating || loginVM.isAuthenticating ? 0 : 1)
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showLoginSheet = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                isAuthenticated = true
                            }
                            return .success
                        } catch {
                            return .failed("\(error.localizedDescription)")
                        }
                    } else {
                        //  Регистрация
                        do {
                            try await registrationVM.createUser()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showLoginSheet = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                isAuthenticated = true
                            }
                            return .success
                        } catch {
                            return .failed("\(error.localizedDescription)")
                        }
                    }
                    
                }
                .buttonStyle(.opacityLess)
                /// Disable button when form is not valid and the button is in the Login or Get Started state
                .disabled(!(alreadyHavingAccount ? loginVM.formIsValid : registrationVM.formIsValid))
                .opacity((alreadyHavingAccount ? loginVM.formIsValid : registrationVM.formIsValid) ? 1 : 0.7)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Spacer(minLength: 110)
            
        }
        .padding(15)
        .padding(.top, 15)
        
        .overlay(alignment: .bottom, content: {
            HStack(spacing: 4) {
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
                    HaskTextView(
                        text: (alreadyHavingAccount ? "Create an Account" : "Login"),
                        trigger: alreadyHavingAccount,
                        transition: .interpolate,
                        speed: 0.1
                    )
                    .tint(Color.primary)
                }
            }
            .font(.callout)
            .textScale(.secondary)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 15)
            .padding(.horizontal, 10)
            .multilineTextAlignment(.center)
            .transition(.opacity)
        })
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    LoginView(showLoginSheet: .constant(false), isAuthenticated: .constant(true))
}
