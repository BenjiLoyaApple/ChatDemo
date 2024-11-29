//
//  MessageRepresentable.swift
//  Components
//
//  Created by Benji Loya on 26.11.2024.
//

import Foundation
import LinkPresentation

public protocol MessageRepresentable {
    var messageId: String { get }
    var fromId: String { get }
    var toId: String { get }
    var caption: String { get }
    var timestamp: Date { get }
    var imageUrl: String? { get }
    var read: Bool { get }
    var contentType: ContentType { get }
}

public enum ContentType {
    case text(String)
    case image(String)
    case link(LinkMetadataWrapper)
}

/// Обертка для метаданных ссылки
public struct LinkMetadataWrapper: Codable, Hashable {
    public let title: String?
    public let originalURL: URL?
    public let imageData: Data?

    public init(metadata: LPLinkMetadata, imageData: Data?) {
        self.title = metadata.title
        self.originalURL = metadata.originalURL
        self.imageData = imageData
    }
}
