//
//  PreviewProvider.swift
//  ChatApp
//
//  Created by Benji Loya on 16.08.2023.
//

import SwiftUI
import Firebase
import LinkPresentation

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    // Моковый пользователь
       var user: User {
           User(
               userId: "12345",
               username: "benjiloya",
               fullname: "Benji Loya",
               email: "batman@gmail.com",
               profileImageUrl: nil,
               bio: "Just a superhero in disguise.",
               link: "https://batman.com"
           )
       }
       
       // Массив моковых сообщений
    var messages: [Message] {
        [
            Message(
                messageId: "1",
                fromId: "12345",
                toId: "67890",
                caption: "Hello! This is a test message.",
                timestamp: Timestamp(),
                user: user,
                read: false,
                imageUrl: "https://i.pinimg.com/originals/63/f0/17/63f017a7b9ad24d609b404515d86f9f4.jpg"
            ),
            Message(
                messageId: "2",
                fromId: "67890",
                toId: "12345",
                caption: "Hi! Here's another test message.\nstring test message.",
                timestamp: Timestamp(),
                user: user,
                read: true,
                imageUrl: nil
            )
        ]
    }
    
     func createMessage(id: String, caption: String, read: Bool, imageUrl: String? = nil) -> Message {
            Message(
                messageId: id,
                fromId: user.userId ?? "nil",
                toId: "67890",
                caption: caption,
                timestamp: Timestamp(),
                user: user,
                read: read,
                imageUrl: imageUrl
            )
        }
    
    // Создаем метаданные ссылки
    var linkMetadataWrapper: LinkMetadataWrapper {
        let metadata = LPLinkMetadata()
        metadata.title = "Apple"
        metadata.originalURL = URL(string: "https://www.apple.com/iphone/")
        
        // Создаем данные изображения для метаданных ссылки
        let imageData = try? Data(contentsOf: URL(string: "https://www.apple.com/ac/structured-data/images/open_graph_logo.png?202110180743")!)
        
        // Оборачиваем метаданные ссылки
        return LinkMetadataWrapper(metadata: metadata, imageData: imageData)
    }
    
    lazy var imageUrlString =  "https://i.pinimg.com/originals/63/f0/17/63f017a7b9ad24d609b404515d86f9f4.jpg"
    
}

//MARK: - ActiveNow MOCK DATA
extension ActiveNowViewModel {
    static var mockActive: ActiveNowViewModel {
        let viewModel = ActiveNowViewModel()
        viewModel.isLoading = true
        
        viewModel.users = [
                    DeveloperPreview.shared.user,
                    DeveloperPreview.shared.user,
                    DeveloperPreview.shared.user,
                    DeveloperPreview.shared.user
                ]
        
        return viewModel
    }
}

//MARK: - Inbox MOCK DATA
extension InboxViewModel {
    static var mock: InboxViewModel {
        let viewModel = InboxViewModel()
        viewModel.didCompleteInitialLoad = true
        
        viewModel.recentMessages = [
            DeveloperPreview.shared
                .createMessage(
                    id: "1",
                    caption: "Hello! This is a test message.",
                    read: false,
                    imageUrl: "https://i.pinimg.com/originals/63/f0/17/63f017a7b9ad24d609b404515d86f9f4.jpg"
                ),
            DeveloperPreview.shared
                .createMessage(
                    id: "2",
                    caption: "Hi! Another test message with a multi-line caption to showcase.",
                    read: true
                ),
            DeveloperPreview.shared
                .createMessage(
                    id: "3",
                    caption: "Third message to add more content.",
                    read: false,
                    imageUrl: "https://i.pinimg.com/originals/63/f0/17/63f017a7b9ad24d609b404515d86f9f4.jpg"
                ),
            DeveloperPreview.shared
                .createMessage(
                    id: "4",
                    caption: "Just another day, another message.",
                    read: true
                )
        ]
        return viewModel
    }
}
