//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 12.08.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import PhotosUI
import SwiftUI
import LinkPresentation

class ChatViewModel: ObservableObject {
    @Published var linkMetaData: LinkMetadataWrapper?
    @Published var previewLoading = false
    @Published var messages = [Message]()
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }
    @Published var messageImage: Image?
    
    private let service: ChatServiceProtocol
    private var uiImage: UIImage?
    
    init(service: ChatServiceProtocol) {
        self.service = service
        observeChatMessages()
    }
    
    func observeChatMessages() {
        service.observeMessages { [weak self] messages in
            guard let self = self else { return }
            self.messages.append(contentsOf: messages)
            Task {
                try? await UserService.shared.updateLastActive()
            }
        }
    }
    
    @MainActor
    func sendMessageAndClearState(_ messageText: String) async {
        do {
            if messageImage != nil {
                try await sendMessage("")
            } else if let url = URL(string: messageText), UIApplication.shared.canOpenURL(url) {
                previewLoading = true
                fetchLinkMetaData(for: url) { [weak self] in
                    self?.previewLoading = false
                    Task { try await self?.sendMessage(messageText) }
                }
            } else {
                try await sendMessage(messageText)
            }
            
            messageImage = nil
            uiImage = nil
            linkMetaData = nil
        } catch {
            print("Ошибка при отправке сообщения: \(error.localizedDescription)")
        }
    }
    
    func fetchLinkMetaData(for url: URL, completion: @escaping () -> Void) {
        let provider = LPMetadataProvider()
        provider.startFetchingMetadata(for: url) { [weak self] meta, error in
            guard let self = self else { return }
            if let meta = meta {
                self.extractImageData(from: meta) { imageData in
                    let metaDataWrapper = LinkMetadataWrapper(metadata: meta, imageData: imageData)
                    DispatchQueue.main.async {
                        self.linkMetaData = metaDataWrapper
                        completion()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.linkMetaData = nil
                    completion()
                }
            }
        }
    }

    private func extractImageData(from metadata: LPLinkMetadata, completion: @escaping (Data?) -> Void) {
        guard let provider = metadata.imageProvider else {
            completion(nil)
            return
        }

        provider.loadObject(ofClass: UIImage.self) { image, error in
            let imageData = (image as? UIImage)?.pngData()
            completion(imageData)
        }
    }

    @MainActor
    func sendMessage(_ messageText: String) async throws {
        if let image = uiImage {
            try await service.sendMessage(type: .image(image))
            messageImage = nil
            uiImage = nil
        } else if let linkMetaData = linkMetaData {
            try await service.sendMessage(type: .link(linkMetaData))
        } else {
            try await service.sendMessage(type: .text(messageText))
        }
    }
    
    func updateMessageStatusIfNecessary() async throws {
        guard let lastMessage = messages.last else { return }
        try await service.updateMessageStatusIfNecessary(lastMessage)
    }
    
    func nextMessage(forIndex index: Int) -> Message? {
        return index != messages.count - 1 ? messages[index + 1] : nil
    }
    
    func removeChatListener() {
        service.removeListener()
    }
}

// MARK: - Images

extension ChatViewModel {
    
    @MainActor
    func loadImage() async throws {
        guard let selectedItem = selectedItem else { return }
        guard let uiImage = try await PhotosPickerHelper.loadImage(fromItem: selectedItem) else { return }
        self.uiImage = uiImage
        messageImage = Image(uiImage: uiImage)
    }
}
