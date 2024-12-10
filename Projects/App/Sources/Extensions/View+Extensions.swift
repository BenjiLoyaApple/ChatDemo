//
//  View+Extensions.swift
//
//  Created by Benji Loya on 14/12/2022.
//

import SwiftUI

//MARK: - LOGIN SHEET
extension View {
    @ViewBuilder
    func heightChangePreference(completion: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader(content: { geometry in
                    Color.clear
                        .preference(key: OffsetKeyLogin.self, value: geometry.size.height)
                        .onPreferenceChange(OffsetKeyLogin.self, perform: { value in
                            completion(value)
                        })
                })
            }
    }
}

extension View {
    @ViewBuilder
    func minXChangePreference(completion: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader(content: { geometry in
                    Color.clear
                        .preference(key: OffsetKeyLogin.self, value: geometry.frame(in: .scrollView).minX)
                        .onPreferenceChange(OffsetKeyLogin.self, perform: { value in
                            completion(value)
                        })
                })
            }
    }
}

//MARK: - PLACEHOLDERS
extension View {
    func placeholderActiveNow() -> some View {
        VStack {
            Image("nullProfile")
                .resizable()
                .scaledToFill()
                .frame(width: 72, height: 72)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.25), lineWidth: 0.5)
                )
                
            Text("benjiloya")
                .font(.footnote)
                .foregroundColor(.primary.opacity(0.8))
        }
        .redacted(reason: .placeholder)
        .shimmer(.init(tint: Color.theme.buttonsPostCard.opacity(0.4), highlight: .gray, blur: 5))
    }
}

//MARK: - placeholder Recent Chats
extension View {
    func placeholderRecentChats() -> some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 6) {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.gray.opacity(0.25))
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(alignment: .top, spacing: 10) {
                        Text("user name")
                            .fontWeight(.semibold)
                        
                        Spacer(minLength: 0)
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("The first post title here")
                        
                        Text("The first post description here")
                    }
                    .font(.system(size: 15))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
        .padding(.bottom, 20)
        .redacted(reason: .placeholder)
        .shimmer(.init(tint: Color.theme.buttonsPostCard.opacity(0.4), highlight: .gray, blur: 5))
    }
}

//MARK: - Shine Effect
extension View {
    /// Custom View Modifier
    @ViewBuilder
    func shine(_ toggle: Bool, duration: CGFloat = 0.5, clipShape: some Shape = .rect, rightToLeft: Bool = false) -> some View {
        self
            .overlay {
                GeometryReader {
                    let size = $0.size
                    /// Negative Dutation
                    let moddedDuration = max(0.3, duration)
                    
                    Rectangle()
                        .fill(.linearGradient(
                            colors: [
                                .clear,
                                .white.opacity(0.1),
                                .white.opacity(0.5),
                                .white.opacity(0.8),
                                .white.opacity(0.5),
                                .white.opacity(0.1),
                                .clear
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .scaleEffect(y: 8)
                        .keyframeAnimator(initialValue: 0.0, trigger: toggle, content: {
                            content, progress in
                            content
                                .offset(x: -size.width + (progress * (size.width * 2)))
                        }, keyframes: { _ in
                            CubicKeyframe(.zero, duration: 0.1)
                            CubicKeyframe(1, duration: moddedDuration)
                        })
                        .rotationEffect(.init(degrees: 25))
                        .scaleEffect(x: rightToLeft ? -1 : 1)
                    
                }
            }
            .clipShape(clipShape)
    }
}
