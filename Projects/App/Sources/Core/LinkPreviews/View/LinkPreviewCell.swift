//
//  LinkPreview.swift
//  ChatApp
//
//  Created by Benji Loya on 16.08.2023.
//

import SwiftUI

struct LinkPreviewCell: View {
    let linkMetaData: LinkMetadataWrapper

    var body: some View {
        if let url = linkMetaData.originalURL {
            Link(destination: url) {
                VStack(alignment: .leading, spacing: 6) {
                    if let imageData = linkMetaData.imageData, let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 170)
                            .cornerRadius(1)
                    }
                    
                    Text(url.absoluteString)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .padding(.horizontal, 15)
                    
                    if let title = linkMetaData.title {
                        Text(title)
                            .font(.footnote)
                            .foregroundColor(Color.theme.darkWhite)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 15)
                    }
                    
                }
                .padding(.bottom, 10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
                )
            }
        } else {
            // Optional: handle the case where `originalURL` is nil
            Text("Invalid URL")
                .padding(.horizontal, 15)
        }
    }
}

#Preview {
    LinkPreviewCell(linkMetaData: DeveloperPreview.shared.linkMetadataWrapper)
        .padding()
}

