//
//  IntrosView.swift
//  ChatApp
//
//  Created by Benji Loya on 31.08.2024.
//

import SwiftUI

struct IntrosView: View {
    
    @StateObject var logigVM = LoginViewModel()
    @StateObject var registrationVM = RegistrationViewModel()
    
    /// View Properties
    @State private var activePage: Page = .page1
    @State private var showSheet: Bool = false
    
    @State private var emailAdress: String = ""
    @State private var password: String = ""
    @State private var alreadyHavingAccount: Bool = true
    @State private var sheetHeight: CGFloat = .zero
    /// View's Height (Storing For Swipe Calculation)
    @State private var sheetFirstPageHeight: CGFloat = .zero
    @State private var sheetSecondPageHeight: CGFloat = .zero
    @State private var sheetScrollProgress: CGFloat = .zero
    /// Other Properties
    @State private var isKeyboardShowing: Bool = false
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack {
                Spacer(minLength: 0)
                
                MorphingSymbolView(
                    symbol: activePage.rawValue,
                    config: .init(
                        font: .system(size: 150, weight: .bold),
                        frame: .init(width: 250, height: 200),
                        radius: 30,
                        foregroudColor: .white
                    )
                )
                
                TextContent(size: size)
                
                Spacer(minLength: 0)
                
                IndicatorView()
                    .padding(.bottom)
                
                ContinueButton()
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .top) {
                HeaderView()
            }
        }
        .background {
            Rectangle()
                .fill(.black.gradient)
                .ignoresSafeArea()
        }
        .alert(isPresented: Binding<Bool>(
            get: { logigVM.showAlert || registrationVM.showAlert },
            set: { newValue in
                logigVM.showAlert = newValue
                registrationVM.showAlert = newValue
            }
        )) {
            let errorMessage = logigVM.authError?.localizedDescription
                            ?? registrationVM.authError?.localizedDescription
                            ?? "An unknown error occurred."
            return Alert(title: Text("Error"), message: Text(errorMessage))
        }
        
        .sheet(isPresented: $showSheet, onDismiss: {
            /// Resetting Properties
            sheetHeight = .zero
            sheetFirstPageHeight = .zero
            sheetSecondPageHeight = .zero
            sheetScrollProgress = .zero
        }, content: {
            /// Sheet View
            GeometryReader(content: { geometry in
                let size = geometry.size
                
                ScrollViewReader(content: { proxy in
                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: 0) {
                            OnBoarding(size)
                                .id("First Page")
                            
                            LoginView(size)
                                .id("Second Page")
                        }
                        /// For Paging Needs to be Enabled
                        .scrollTargetLayout()
                    }
                    /// Enabling Paging ScrollView
                    .scrollTargetBehavior(.paging)
                    .scrollIndicators(.hidden)
                    /// Disabling ScrollView when Keyboard is Visible
                    .scrollDisabled(isKeyboardShowing)
                    /// Custom button Which will be Updated over scroll
                    .overlay(alignment: .topTrailing) {
                        Button(action: {
                            if sheetScrollProgress < 1 {
                                /// Continue Button
                                ///  Moving to the next page (Using ScrollView Reader
                                withAnimation(.snappy) {
                                    proxy.scrollTo("Second Page", anchor: .leading)
                                }
                            } else {
                                if alreadyHavingAccount {
                                    // Логин
                                    Task {
                                        do {
                                            try await logigVM.login()
                                        } catch {
                                            print("Ошибка входа: \(error.localizedDescription)")
                                        }
                                    }
                                } else {
                                    // Регистрация
                                    Task {
                                        do {
                                            try await registrationVM.createUser()
                                        } catch {
                                            print("Ошибка регистрации: \(error.localizedDescription)")
                                        }
                                    }
                                }
                            }
                        }, label: {
                            Text("Continie")
                                .fontWeight(.semibold)
                                .opacity(1 - sheetScrollProgress)
                            /// Adding Some Extra Width for Second Page
                                .frame(width: 120 + (sheetScrollProgress * (alreadyHavingAccount ? 0 : 50)))
                                .overlay(content: {
                                    /// Next Page Text
                                    HStack(spacing: 8) {
                                        Text(alreadyHavingAccount ? "Login" : "Get Starting")
                                            
                                        
                                        Image(systemName: "arrow.right")
                                    }
                                    .fontWeight(.semibold)
                                    .opacity(sheetScrollProgress)
                                    .opacity(registrationVM.isAuthenticating || logigVM.isAuthenticating ? 0 : 1)
                                    .overlay {
                                        if registrationVM.isAuthenticating || logigVM.isAuthenticating {
                                            ProgressView()
                                                .tint(Color.theme.primaryBackground)
                                        }
                                    }
                                })
                                .padding(.vertical, 12)
                                .foregroundStyle(.white)
                                .background(
                                    .linearGradient(
                                        colors: [.red, .orange],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing),
                                    in: .capsule)
                        })
                        .padding(15)
                        .offset(y: sheetHeight - 100)
                        /// Moving Button Near to the Next View
                        .offset(y: sheetScrollProgress * -120)
                        // Disable button when form is not valid and the button is in the Login or Get Started state
                        .disabled(sheetScrollProgress >= 1 && !(alreadyHavingAccount ? logigVM.formIsValid : registrationVM.formIsValid))
                        .opacity(sheetScrollProgress < 1 || (alreadyHavingAccount ? logigVM.formIsValid : registrationVM.formIsValid) ? 1 : 0.7)
                    }
                })
            })
            /// Presentation Customization
            .presentationCornerRadius(30)
            /// Presemtation Detents
            .presentationDetents(sheetHeight == .zero ? [.medium] : [.height(sheetHeight)])
            /// Disabling swipe to Dismiss
            .interactiveDismissDisabled()
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification), perform: { _ in
                isKeyboardShowing = true
            })
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification), perform: { _ in
                isKeyboardShowing = false
            })
        })
           
    }
    
    //MARK: - onBoarding
    /// Header View
    @ViewBuilder
    private func HeaderView() -> some View {
        HStack {
            Button {
                activePage = activePage.previousPage
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .containerShape(.rect)
            }
            .opacity(activePage != .page1 ? 1 : 0)
            
            Spacer(minLength: 0)
            
            Button("Skip") {
                activePage = .page4
            }
            .fontWeight(.semibold)
            .opacity(activePage != .page4 ? 1 : 0)
        }
        .foregroundStyle(.white)
        .animation(.snappy(duration: 0.33, extraBounce: 0), value: activePage)
        .padding(15)
        .padding(.horizontal, 10)
    }
    
    /// Text Content
    @ViewBuilder
    private func TextContent(size: CGSize) -> some View {
        VStack(spacing: 8) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(Page.allCases, id: \.rawValue) { page in
                    Text(page.title)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .kerning(1.1)
                        .frame(width: size.width)
                }
            }
            /// Sliding Left/Right based on the active Page
            .offset(x: -activePage.index * size.width)
            .animation(.smooth(duration: 0.7, extraBounce: 0.1), value: activePage)
            
            HStack(alignment: .top, spacing: 0) {
                ForEach(Page.allCases, id: \.rawValue) { page in
                    Text(page.subTitle)
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.gray)
                        .frame(width: size.width)
                }
            }
            /// Sliding Left/Right based on the active Page
            .offset(x: -activePage.index * size.width)
            /// Adding a little delay
            .animation(.smooth(duration: 0.9, extraBounce: 0.1), value: activePage)
            
        }
        .padding(.top, 15)
        .frame(width: size.width, alignment: .leading)
    }
    
    /// Indicator View
    @ViewBuilder
    private func IndicatorView() -> some View {
        HStack(spacing: 6) {
            ForEach(Page.allCases, id: \.rawValue) { page in
                Capsule()
                    .fill(.white.opacity(activePage == page ? 1 : 0.4))
                    .frame(width: activePage == page ? 25 : 8, height: 8)
            }
        }
    }
    
    /// Continue Button
    @ViewBuilder
    private func ContinueButton() -> some View {
        Button {
            if activePage == .page4 {
                showSheet = true // Show the login sheet
            } else {
                activePage = activePage.nextPage
            }
        } label: {
            Text(activePage == .page4 ? "Start" : "Continue")
                .contentTransition(.identity)
                .foregroundStyle(.black)
                .padding(.vertical, 15)
                .frame(maxWidth: activePage == .page4 ? 220 : 180)
                .background(.white, in: .capsule)
        }
        .padding(.bottom, 15)
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
    }
    
    //MARK: - Sheet View
    /// First View (Onboarding)
    @ViewBuilder
    func OnBoarding(_ size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 12, content: {
            Text("Where developers\ngrow together")
                .font(.largeTitle.bold())
                .lineLimit(2)
            
            /// Custom Attributed Subtitle
            Text(attributedSubTitle)
                .font(.callout)
                .foregroundStyle(.gray)
        })
        .padding(15)
        .padding(.horizontal, 10)
        .padding(.top, 15)
        .padding(.bottom, 130)
        .frame(width: size.width, alignment: .leading)
        /// Finding the view's Height
        .heightChangePreference { height in
            sheetFirstPageHeight = height
            /// Since the Sheet Height will be same as the First/Initial Page Height
            sheetHeight = height
        }
    }
    
    var attributedSubTitle: AttributedString {
        let string = "Join now and connect with fellow developers instantly"
        var attString = AttributedString(stringLiteral: string)
        
        if let range = attString.range(of: "connect") {
            attString[range].foregroundColor = Color.theme.darkWhite
            attString[range].font = .callout.bold()
        }
        
        if let range = attString.range(of: "developers") {
            attString[range].foregroundColor = Color.theme.darkWhite
            attString[range].font = .callout.bold()
        }
        
        return attString
    }
    
    /// Login View ()
    @ViewBuilder
    func LoginView(_ size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(alreadyHavingAccount ? "Login" : "Create an Account")
                .font(.largeTitle.bold())
            
            if alreadyHavingAccount {
                /// Login
                CustomTF(hint: "Email Adress", text: $logigVM.email, icon: "envelope")
                    .padding(10)
                
                CustomTF(hint: "*****", text: $logigVM.password, icon: "lock", isPassword: true)
                    .padding(10)
            } else {
                /// Registration
                CustomTF(hint: "Username", text: $registrationVM.username, icon: "person")
                    .padding(10)
                
                CustomTF(hint: "Email Adress", text: $registrationVM.email, icon: "envelope")
                    .padding(10)
                
                CustomTF(hint: "*****", text: $registrationVM.password, icon: "lock", isPassword: true)
                    .padding(10)
            }
        }
        .padding(15)
        .padding(.horizontal, 10)
        .padding(.top, 15)
        .padding(.bottom, 220)
        .overlay(alignment: .bottom, content: {
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
                            .tint(Color.theme.darkWhite)
                        }
                        .transition(.push(from: .bottom))
                    } else {
                        HStack(spacing: 4) {
                            Text("Already having an account?")
                                .foregroundStyle(.gray)
                            
                            Button("Login") {
                                withAnimation(.snappy) {
                                    alreadyHavingAccount.toggle()
                                }
                            }
                            .tint(Color.theme.darkWhite)
                        }
                        .transition(.push(from: .top))
                    }
                }
                .font(.callout)
                .textScale(.secondary)
                .padding(.bottom, alreadyHavingAccount ? 0 : 15)
                
                if !alreadyHavingAccount {
                    /// Markup Text
                    Text("By signing up, you're agreeing to our **[Terms & Condition](https:apple.com)** and **[Privacy Policy](https:apple.com)**")
                        .font(.caption)
                    /// Markup Content will be Red
                        .tint(Color.theme.darkWhite)
                    /// Others will be Gray
                        .foregroundStyle(.gray)
                        .transition(.offset(y: 100))
                }
            }
            .padding(.bottom, 15)
            .padding(.horizontal, 20)
            .multilineTextAlignment(.center)
            .frame(width: size.width)
        })
        .frame(width: size.width)
        /// Finding the view's Height
        .heightChangePreference { height in
            sheetSecondPageHeight = height
            /// Just in case, if the second page height is changed
            let diff = sheetSecondPageHeight - sheetFirstPageHeight
            sheetHeight = sheetFirstPageHeight + (diff * sheetScrollProgress)
        }
        /// Offset Preference
        .minXChangePreference { minX in
            let diff = sheetSecondPageHeight - sheetFirstPageHeight
            /// Truncating Minx between (0 to Screen Width
            let truncatedMinX = min(size.width - minX, size.width)
            guard truncatedMinX > 0 else { return }
            /// Converting MinX to Progress (0 -1)
            let progress = truncatedMinX / size.width
            sheetScrollProgress = progress
            /// Adding the Difference Height to the Sheet Height
            sheetHeight = sheetFirstPageHeight + (diff * progress)
        }
    }
    
}

#Preview {
    IntrosView()
}
