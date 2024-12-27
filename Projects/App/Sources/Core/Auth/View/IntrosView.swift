//
//  IntrosView.swift
//  ChatApp
//
//  Created by Benji Loya on 25.12.2024.
//

import SwiftUI
import Components

struct IntrosView: View {
    /// Animation Properties
    @State private var showWalkThroughScreens: Bool = false
    @State private var currentIndex: Int = 0
    @State private var showHomeView: Bool = false
    @Namespace private var animation
    
    /// EULA
    @AppStorage("isEULAagreed") private var isEULAagreed: Bool = false
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    
    @State private var showEULA: Bool = false
    @State private var showLoginSheet: Bool = false
    
    var body: some View {
        ZStack {
            if showHomeView {
                /// Home view
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
    
    // MARK: - WalkThrough Screens
    @ViewBuilder
    func WalkThroughScreens() -> some View {
        let isLast = currentIndex == intros.count
        
        GeometryReader {
            let size = $0.size
            
            ZStack {
                // MARK: Walk Through Screens
                ForEach(intros.indices,id: \.self) { index in
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
                    .opacity(isLast ? (isEULAagreed ? 1 : 0.4) : 0)
                }
                .frame(width: isLast ? size.width / 1.5 : 55, height: isLast ? 50 : 55)
                .background {
                    RoundedRectangle(cornerRadius: isLast ? 10 : 30, style: isLast ? .continuous : .circular)
                        .fill(Color.theme.darkWhite)
                }
                .onTapGesture {
                    if currentIndex == intros.count {
                        // Signup Action
                        if isEULAagreed {
                            //  showHomeView = true
                            //  isAuthenticated = true
                            showLoginSheet.toggle()
                        }
                    } else {
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
                    /// Markup Text
                    Text(attributedSubTitle)
                        .font(.caption)
                    /// Markup Content will be Red
                        .tint(Color.theme.darkWhite)
                    /// Others will be Gray
                        .foregroundStyle(.gray)
                        .transition(.offset(y: 100))
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical, -15)
                .offset(y: isLast ? -12 : 100)
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
                .onTapGesture {
                    showEULA.toggle()
                }
            })
            .offset(y: showWalkThroughScreens ? 0 : size.height)
            .fullScreenCover(isPresented: $showEULA) {
                EULAView(isEULAagreed: $isEULAagreed)
            }
            .sheet(isPresented: $showLoginSheet, onDismiss: {
                if !showLoginSheet {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        showHomeView = true
                    }
                }
            }) {
                LoginView(showLoginSheet: $showLoginSheet, isAuthenticated: $isAuthenticated)
                    .presentationDetents([.height(450), .large])
                    .presentationCornerRadius(25)
                    .presentationDragIndicator(.hidden)
            .interactiveDismissDisabled()
            }
        }
    }
    
    var attributedSubTitle: AttributedString {
        let string = "By signing up, you're agreeing to our \nTerms & Condition and Privacy Policy"
        var attString = AttributedString(stringLiteral: string)
        
        if let range = attString.range(of: "Terms & Condition") {
            attString[range].foregroundColor = Color.theme.darkWhite
            attString[range].font = .caption.bold()
        }
        
        if let range = attString.range(of: "Privacy Policy") {
            attString[range].foregroundColor = Color.theme.darkWhite
            attString[range].font = .caption.bold()
        }
        
        return attString
    }
    
    // MARK: - Indicator View
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
    
    // MARK: - Screen View
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
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.primary.opacity(0.001))
                .frame(height: 250,alignment: .top)
                .padding(.horizontal,20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .overlay {
                    MorphingSymbolIntros(currentIndex: $currentIndex)
                        .offset(x: -size.width * CGFloat(currentIndex - index))
                }
            
            
//            Image(intro.imageName)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(height: 250,alignment: .top)
//                .padding(.horizontal,20)
//                .offset(x: -size.width * CGFloat(currentIndex - index))
//                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
        }
        .offset(y: -30)
    }
    
    // MARK: - Welcome View
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
    }
    
    // MARK: - Nav Bar
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
                    if currentIndex > 0 {
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
    
    // MARK: - Intro View
    @ViewBuilder
    func IntroScreen() -> some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 10) {
                Image("Intro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height / 2)
                    .overlay(alignment: .bottom) {
                        LinearGradient(
                            colors: [
                                .clear,
                                .clear,
                                Color.theme.darkBlack.opacity(0.01),
                                Color.theme.darkBlack.opacity(0.55),
                                Color.theme.darkBlack.opacity(0.95),
                                Color.theme.darkBlack
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .padding(.bottom, -20)
                    }
                
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
            
        }
        .ignoresSafeArea()
    }
    
}

struct IntrosView_Previews: PreviewProvider {
    static var previews: some View {
        IntrosView()
    }
}


//MARK: - Morphing Symbol View
struct MorphingSymbolIntros: View {
    @Binding var currentIndex: Int
    var body: some View {
        VStack {
                  if currentIndex < intros.count {
                      MorphingSymbolView(
                          symbol: intros[currentIndex].systemImageName,
                          config: .init(
                              font: .system(size: 150, weight: .bold),
                              frame: .init(width: 250, height: 200),
                              radius: 30,
                              foregroundColor: .primary.opacity(0.8)
                          )
                      )
                  }
              }
              .padding()
    }
}


/*
 
            .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        if !isEULAagreed {
                            print("EULA agreed, showing EULA...")
                            withAnimation {
                                showEULA = true
                            }
                        }
                    }
            }
 
*/
