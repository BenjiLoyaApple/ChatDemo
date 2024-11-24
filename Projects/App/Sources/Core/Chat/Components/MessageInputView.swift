//
//  MessageInputView.swift
//  ChatApp
//
//  Created by Benji Loya on 16.08.2023.
//

import SwiftUI
import PhotosUI

struct MessageInputView: View {
    @Binding var messageText: String
    @ObservedObject var viewModel: ChatViewModel

    @State private var showPhotoPicker: Bool = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            HStack {
                if let image = viewModel.messageImage {
                    ZStack(alignment: .topTrailing) {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Rectangle())
                            .frame(width: 80, height: 100)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
                            )

                        CustomChatButton(
                            imageName: .systemName("xmark.circle.fill"),
                            font: .callout,
                            foregroundStyle: .gray.opacity(0.8),
                            padding: 5,
                            onButtonPressed: {
                                viewModel.messageImage = nil
                            }
                        )
                    }
                    .padding(8)

                    Spacer()
                } else {
                    TextField("Message...", text: $messageText, axis: .vertical)
                        .padding(12)
                        .padding(.leading, 4)
                        .padding(.trailing, 48)
                        .background {
                            TransparentBlurView(removeAllFilters: true)
                                .blur(radius: 50, opaque: true)
                                .background(Color.theme.messageImputBG.opacity(0.5))
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .font(.subheadline)
                    
//                    if !messageText.isEmpty {
//                        Button(action: {
//                            messageText = ""
//                        }) {
//                            Image(systemName: "xmark.circle.fill")
//                                .foregroundColor(.gray.opacity(0.8))
//                                .padding(.trailing, 16)
//                        }
//                    }
                    
                }
            }

            HStack(spacing: 0) {
                if messageText.isEmpty && viewModel.messageImage == nil {
                    
                    CustomChatButton(
                        imageName: .assetName("gallery"),
                        font: .system(size: 10),
                        padding: 12,
                        frame: CGSize(width: 22, height: 22),
                        onButtonPressed: {
                            showPhotoPicker.toggle()
                        }
                    )
                    
                    CustomChatButton(
                        imageName: .systemName("mic"),
                        text: "",
                        font: .title3,
                        foregroundStyle: .primary,
                        padding: 5,
                        onButtonPressed: {
                            
                        }
                    )
                }
                
                Button {
                    if messageText.isEmpty && viewModel.messageImage == nil {
                        // Открываем фото пикер
                      //  showPhotoPicker.toggle()
                    } else {
                        // Отправляем сообщение
                        Task {
                            await viewModel.sendMessageAndClearState(messageText)
                            messageText = ""
                        }
                    }
                    
                } label: {
                    MorphingSymbolView(
                        symbol: messageText.isEmpty && viewModel.messageImage == nil ? "circle.square" : "paperplane.fill",
                        config: .init(
                            font: .title2,
                            frame: .init(width: 50, height: 50),
                            radius: 2,
                            foregroudColor: .primary,
                            keyFrameDuration: 0.3,
                            symbolAnimation: .smooth(duration: 0.3, extraBounce: 0)
                        )
                    )
                    .clipShape(.circle)
                }
            }
            .padding(.trailing, 10)
        }
        .background(viewModel.messageImage != nil ? Color.theme.igChatBG : Color.clear)
                
        .photosPicker(
            isPresented: $showPhotoPicker,
            selection: Binding<[PhotosPickerItem]>(
                get: {
                    viewModel.selectedItem.map { [$0] } ?? []
                },
                set: { newValue in
                    viewModel.selectedItem = newValue.first
                }
            ),
            maxSelectionCount: 1,
            selectionBehavior: .ordered
        )
        .overlay {
            // когда выбрано фото
            if viewModel.messageImage != nil {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.gray), lineWidth: 0.5)
            }
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    MessageInputView(
        messageText: .constant(""),
        viewModel: ChatViewModel(service: DIContainer.shared.createChatService(chatPartner: .mock))
    )
}
