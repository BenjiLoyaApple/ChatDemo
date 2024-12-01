//
//  CustomButton.swift
//  ios17
//
//  Created by Benji Loya on 06.09.2023.
//

import SwiftUI

public struct CustomLoginButton<ButtonContent: View>: View {
    public var buttonTint: Color = .white
    public var content: () -> ButtonContent
    /// Button Action
    public var action: () async -> TaskStatus
    /// View Properties
    @State private var isLoading: Bool = false
    @State private var taskStatus: TaskStatus = .idle
    @State private var isFailed: Bool = false
    @State private var wiggle: Bool = false
    /// Popup Properties
    @State private var showPopup: Bool = false
    @State private var popupMessage: String = ""
    
    public init(
            buttonTint: Color = .white,
            @ViewBuilder content: @escaping () -> ButtonContent,
            action: @escaping () async -> TaskStatus
        ) {
            self.buttonTint = buttonTint
            self.content = content
            self.action = action
        }
    
    public var body: some View {
        Button(action: {
            Task {
                isLoading = true
                let taskStatus = await action()
                switch taskStatus {
                case .idle:
                    isFailed = false
                case .failed(let string):
                    isFailed = true
                    popupMessage = string
                case .success:
                    isFailed = false
                }
                self.taskStatus = taskStatus
                if isFailed {
                    try? await Task.sleep(for: .seconds(0))
                    wiggle.toggle()
                }
                
                try? await Task.sleep(for: .seconds(0.8))
                if isFailed {
                    showPopup = true
                }
                self.taskStatus = .idle
                isLoading = false
            }
        }, label: {
            content()
                .padding(.horizontal, 100)
                .padding(.vertical, 12)
                .opacity(isLoading ? 0 : 1)
                .lineLimit(1)
                .frame(width: isLoading ? 50 : nil, height: isLoading ? 50 : nil)
                .background(Color(taskStatus == .idle ? buttonTint : taskStatus == .success ? .green : .red).shadow(.drop(color: .black.opacity(0.15), radius: 6)), in: .capsule)
                .overlay {
                    if isLoading && taskStatus == .idle {
                        ProgressView()
                    }
                }
                .overlay {
                    if taskStatus != .idle {
                        Image(systemName: isFailed ? "exclamationmark" : "checkmark")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                    }
                }
                .wiggle(wiggle)
        })
        .disabled(isLoading)
        .popover(isPresented: $showPopup, content: {
            Text(popupMessage)
                .font(.caption)
                .foregroundStyle(.gray)
                .padding(.horizontal, 10)
                .presentationCompactAdaptation(.popover)
        })
        .animation(.snappy, value: isLoading)
        .animation(.snappy, value: taskStatus)
    }
}

/// Custom Opacity Less Button Stule
extension ButtonStyle where Self == OpacityLessButtonStyle {
    public static var opacityLess: Self {
        Self()
    }
}

public struct OpacityLessButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

/// Wiggle Extension
extension View {
    @ViewBuilder
    func wiggle(_ animate: Bool) -> some View {
        self
            .keyframeAnimator(initialValue: CGFloat.zero, trigger: animate) { view,
            value in
            view
                .offset(x: value)
        } keyframes: { _ in
            KeyframeTrack {
                CubicKeyframe(0, duration: 0.1)
                CubicKeyframe(-5, duration: 0.1)
                CubicKeyframe(5, duration: 0.1)
                CubicKeyframe(-5, duration: 0.1)
                CubicKeyframe(5, duration: 0.1)
                CubicKeyframe(-5, duration: 0.1)
                CubicKeyframe(5, duration: 0.1)
                CubicKeyframe(0, duration: 0.1)
            }
        }
    }
}

public enum TaskStatus: Equatable {
    case idle
    case failed(String)
    case success
}

#Preview {
    HomeButtonView()
}
