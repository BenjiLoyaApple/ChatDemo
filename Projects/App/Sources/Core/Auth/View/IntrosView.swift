//
//  IntrosView.swift
//  ChatApp
//
//  Created by Benji Loya on 31.08.2024.
//

import SwiftUI
import Components

struct IntrosView: View {
    
    @StateObject var loginVM = LoginViewModel()
    @StateObject var registrationVM = RegistrationViewModel()
    /// View Properties
    @State private var activePage: Page = .page1
    @State private var showSheet: Bool = false
    
    @State private var emailAdress: String = ""
    @State private var password: String = ""
    @State private var resetPasswordButtonDisabled: Bool = false
    @State private var alreadyHavingAccount: Bool = true
    @State private var sheetHeight: CGFloat = .zero
    /// View's Height (Storing For Swipe Calculation)
    @State private var sheetFirstPageHeight: CGFloat = .zero
    @State private var sheetSecondPageHeight: CGFloat = .zero
    @State private var sheetScrollProgress: CGFloat = .zero
    /// Other Properties
    @State private var isKeyboardShowing: Bool = false
    
    /// EULA
    @AppStorage("isEULAagreed") private var isEULAagreed: Bool = false
        @State private var showEULA: Bool = false
    
    
    
    
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false
    
    @State private var showLoginSheet: Bool = false
    
    // MARK: Animation Properties
    @State var showWalkThroughScreens: Bool = false
    @State var currentIndex: Int = 0
    @State var showHomeView: Bool = false
    @Namespace var animation
    var body: some View {
        ZStack {
            if showHomeView {
                // Home
                InboxView()
                .transition(.move(edge: .trailing))
            } else {
                ZStack {
                    Color(Color.theme.darkBlack)
                        .ignoresSafeArea()
                    
                    IntroScreen()
                    
                    WalkThroughScreens()
                    
                    NavBar()
                }
                .animation(.interactiveSpring(response: 1.1, dampingFraction: 0.85, blendDuration: 0.85), value: showWalkThroughScreens)
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.35), value: showHomeView)
    }
    
    // MARK: WalkThrough Screens
    @ViewBuilder
    func WalkThroughScreens() -> some View {
        let isLast = currentIndex == intros.count
        
        GeometryReader {
            let size = $0.size
            
            ZStack{
                // MARK: Walk Through Screens
                ForEach(intros.indices,id: \.self){index in
                    ScreenView(size: size, index: index)
                }
                
                WelcomeView(size: size, index: intros.count)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .overlay(alignment: .bottom, content: {
                Indicators()
                    .opacity(isLast ? 0 : 1)
                    .animation(.easeInOut(duration: 0.35), value: isLast)
                    .offset(y: -180)
            })
            // MARK: Next Button
            .overlay(alignment: .bottom) {
                // MARK: Converting Next Button Into SignUP Button
                ZStack {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.theme.darkBlack)
                        .scaleEffect(!isLast ? 1 : 0.001)
                        .opacity(!isLast ? 1 : 0)
                    
                    HStack {
                        Text("Sign Up")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(Color.theme.darkBlack)
                    .padding(.horizontal,15)
                    .scaleEffect(isLast ? 1 : 0.001)
                    .frame(height: isLast ? nil : 0)
                    .opacity(isLast ? 1 : 0)
                }
                .frame(width: isLast ? size.width / 1.5 : 55, height: isLast ? 50 : 55)
                .foregroundColor(.red)
                .background {
                    RoundedRectangle(cornerRadius: isLast ? 10 : 30, style: isLast ? .continuous : .circular)
                        .fill(Color.theme.darkWhite)
                }
                .onTapGesture {
                    if currentIndex == intros.count{
                        // Signup Action
                        showHomeView = true
                  //      isAuthenticated = true
                    }else{
                        // MARK: Updating Index
                        currentIndex += 1
                    }
                }
                .offset(y: isLast ? -40 : -90)
                // Animation
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
            }
            .overlay(alignment: .bottom, content: {
                // MARK: Bottom Sign In Button
                let isLast = currentIndex == intros.count
                
                HStack(spacing: 5) {
                    Text("Already have an account?")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    CustomChatButton(
                        text: "Login",
                        font: .system(size: 14),
                        fontWeight: .semibold,
                        foregroundColor: .primary,
                        padding: 10,
                        onButtonPressed: {
                        //    showLoginSheet.toggle()
                            showSheet.toggle()
                        }
                    )
                }
                .padding(.vertical, -15)
                .offset(y: isLast ? -12 : 100)
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
            })
            .offset(y: showWalkThroughScreens ? 0 : size.height)
        }
    }
    
    // MARK: Indicator View
    // Forgot to add in the YT Video
    @ViewBuilder
    func Indicators() -> some View {
        HStack(spacing: 8) {
            ForEach(intros.indices,id: \.self) { index in
                Circle()
                    .fill(.gray.opacity(0.2))
                    .frame(width: 8, height: 8)
                    .overlay {
                        if currentIndex == index{
                            Circle()
                                .fill(Color.theme.darkWhite)
                                .frame(width: 8, height: 8)
                                .matchedGeometryEffect(id: "INDICATOR", in: animation)
                        }
                    }
            }
        }
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: currentIndex)
    }
    
    @ViewBuilder
    func ScreenView(size: CGSize,index: Int) -> some View {
        let intro = intros[index]
        
        VStack(spacing: 10) {
            Text(intro.title)
                .font(.system(size: 22))
                .fontWeight(.bold)
                // MARK: Applying Offset For Each Screen's
                .offset(x: -size.width * CGFloat(currentIndex - index))
                // MARK: Adding Animation
                // MARK: Adding Delay to Elements based On Index
                // My Delay Starts From Top
                // You can also modify code to start delay from Bottom
                // Delay:
                // 0.2, 0.1, 0
                // Adding Extra 0.2 For Current Index
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Text(intro.subtitle)
                .font(.system(size: 15))
                .fontWeight(.regular)
                .foregroundStyle(.primary.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal,30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            
//            MorphingSymbolView(
//                symbol: intro.systemImageName,
//                config: .init(
//                    font: .system(size: 150, weight: .bold),
//                    frame: .init(width: 250, height: 200),
//                    radius: 30,
//                    foregroundColor: .primary
//                )
//            )
            
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250,alignment: .top)
                .padding(.horizontal,20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            
        }
        .offset(y: -30)
    }
    
    // MARK: Welcome Screen
    @ViewBuilder
    func WelcomeView(size: CGSize,index: Int)->some View {
        VStack(spacing: 10) {
            Image("Welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250,alignment: .top)
                .padding(.horizontal,20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
            
          //  Text("Chat, share, and grow with your crew.")
            Text("Welcome")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
            
            Text("Hop in and start connecting with your people right now.")
                .font(.system(size: 14))
                .foregroundStyle(.primary.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal,30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
        }
        .offset(y: -30)
        .sheet(isPresented: $showLoginSheet) {
          //  LoginView()
        }
    }
    
    // MARK: Nav Bar
    @ViewBuilder
    func NavBar()->some View {
        let isLast = currentIndex == intros.count
        
        HStack {
            CustomChatButton(
                imageSource: .systemName("chevron.left"),
                font: .subheadline,
                fontWeight: .semibold,
                foregroundColor: Color.theme.darkWhite,
                padding: 10,
                onButtonPressed: {
                    // If Greater Than Zero Then Eliminating Index
                    if currentIndex > 0{
                        currentIndex -= 1
                    }else{
                        showWalkThroughScreens.toggle()
                    }
                }
            )

            Spacer()
            
            CustomChatButton(
                text: "Skip",
                font: .subheadline,
                fontWeight: .semibold,
                foregroundColor: Color.theme.darkWhite,
                padding: 10,
                onButtonPressed: {
                    currentIndex = intros.count
                }
            )
            .opacity(isLast ? 0 : 1)
            .animation(.easeInOut, value: isLast)
            
        }
        .padding(.horizontal,15)
        .padding(.top,10)
        .frame(maxHeight: .infinity,alignment: .top)
        .offset(y: showWalkThroughScreens ? 0 : -120)
    }
    
    @ViewBuilder
    func IntroScreen() -> some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 10) {
                Image("Intro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height / 2)
                
                Text("Hello")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .padding(.top,55)
                
                Text(dummyText)
                    .font(.system(size: 14))
                    .foregroundStyle(.primary.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,30)
                
                Text("Let's Begin")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.darkBlack)
                    .padding(.horizontal,40)
                    .padding(.vertical,14)
                    .background {
                        Capsule()
                            .fill(Color.theme.darkWhite)
                    }
                    .onTapGesture {
                        showWalkThroughScreens.toggle()
                    }
                    .shadow(color: .gray.opacity(0.15), radius: 10)
                    .padding(.top,30)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            // MARK: Moving Up When Clicked
            .offset(y: showWalkThroughScreens ? -size.height : 0)
            
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
                          
                            CustomLoginButton(
                                buttonTint: AnyShapeStyle(
                                    LinearGradient(
                                        colors: [.red, .orange],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                            ) {
                                Text("Continue")
                                    .fontWeight(.semibold)
                                    .opacity(1 - sheetScrollProgress)
                                    /// Adding Some Extra Width for Second Page
                                    .frame(width: 120 + (sheetScrollProgress * (alreadyHavingAccount ? 0 : 50)))
                                    .overlay(content: {
                                        HStack(spacing: 8) {
                                            Text(alreadyHavingAccount ? "Login" : "Get Starting")
                                            Image(systemName: "arrow.right")
                                        }
                                        .fontWeight(.semibold)
                                        .opacity(sheetScrollProgress)
                                        .opacity(registrationVM.isAuthenticating || loginVM.isAuthenticating ? 0 : 1)
                                        .overlay {
                                            if registrationVM.isAuthenticating || loginVM.isAuthenticating {
                                                ProgressView()
                                                    .tint(Color.theme.primaryBackground)
                                            }
                                        }
                                    })
                                    .foregroundStyle(.white)
                            } action: {
                                if sheetScrollProgress < 1 {
                                    /// Continue Button
                                    /// Moving to the next page (Using ScrollView Reader)
                                    withAnimation(.snappy) {
                                        proxy.scrollTo("Second Page", anchor: .leading)
                                    }
                                    return .idle
                                } else {
                                    if alreadyHavingAccount {
                                        // Логин
                                        do {
                                            try await loginVM.login()
                                            return .success
                                        } catch {
                                            return .failed("\(error.localizedDescription)")
                                        }
                                    } else {
                                        // Регистрация
                                        do {
                                            try await registrationVM.createUser()
                                            return .success
                                        } catch {
                                            return .failed("\(error.localizedDescription)")
                                        }
                                    }
                                }
                            }
                            .buttonStyle(.opacityLess)
                            .offset(y: sheetHeight - 100)
                            /// Moving Button Near to the Next View
                            .offset(y: sheetScrollProgress * -120)
                            // Disable button when form is not valid and the button is in the Login or Get Started state
                            .disabled(sheetScrollProgress >= 1 && !(alreadyHavingAccount ? loginVM.formIsValid : registrationVM.formIsValid))
                            .opacity(sheetScrollProgress < 1 || (alreadyHavingAccount ? loginVM.formIsValid : registrationVM.formIsValid) ? 1 : 0.7)
                            .padding(.trailing)
                            
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
        .ignoresSafeArea()
    }
    
    
    /// First View (Sheet)
    @ViewBuilder
    func OnBoarding(_ size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(alreadyHavingAccount ? "Login" : "Create an Account")
                .font(.largeTitle.bold())
            
                /// Login
                CustomTF(hint: "Email Adress", text: $loginVM.email, icon: "envelope")
                    .padding(10)
                
                CustomTF(hint: "*****", text: $loginVM.password, icon: "lock", isPassword: true)
                    .padding(10)
                
                Button {
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
                    
                    // немного переделал значок и надпись по факту, чтоб смотрел юзер почту
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
                
           
        }
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
    
    /// Login View ()
    @ViewBuilder
    func LoginView(_ size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            
            
                /// Registration
                CustomTF(hint: "Username", text: $registrationVM.username, icon: "person")
                    .padding(10)
                
                CustomTF(hint: "Email Adress", text: $registrationVM.email, icon: "envelope")
                    .padding(10)
                
                CustomTF(hint: "*****", text: $registrationVM.password, icon: "lock", isPassword: true)
                    .padding(10)
            
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
            .fullScreenCover(isPresented: $showEULA) {
                    EULAView()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if !isEULAagreed {
                        withAnimation {
                            showEULA = true
                        }
                    }
                }
            }
            
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

struct IntrosView_Previews: PreviewProvider {
    static var previews: some View {
        IntrosView()
    }
}
