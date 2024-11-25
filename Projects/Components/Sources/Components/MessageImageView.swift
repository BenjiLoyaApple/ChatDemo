//
//  MessageImageView.swift
//  ChatApp
//
//  Created by Benji Loya on 02.09.2024.
//

import SwiftUI
import Kingfisher

/// View для отображения изображения сообщения с использованием Kingfisher.
public struct MessageImageView: View {
    /// URL строки изображения
    public let imageUrlString: String
    /// Максимальная ширина изображения
    public var maxWidth: CGFloat
    /// Максимальная высота изображения
    public var maxHeight: CGFloat
    /// Радиус углов изображения
    public var cornerRadius: CGFloat
    /// Цвет обводки изображения
    public var borderColor: Color
    /// Толщина обводки изображения
    public var borderWidth: CGFloat
    
    /// Инициализатор
    public init(
        imageUrlString: String,
        maxWidth: CGFloat = UIScreen.main.bounds.width / 1.5,
        maxHeight: CGFloat = 360,
        cornerRadius: CGFloat = 10,
        borderColor: Color = .gray.opacity(0.3),
        borderWidth: CGFloat = 0.5
    ) {
        self.imageUrlString = imageUrlString
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
    
    public var body: some View {
        KFImage(URL(string: imageUrlString))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
            .clipShape(Rectangle())
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
    }
}

#Preview {
    VStack {
        MessageImageView(
            imageUrlString: "https://via.placeholder.com/600x400.png",
            maxWidth: 300,
            maxHeight: 200,
            cornerRadius: 15,
            borderColor: .blue.opacity(0.5),
            borderWidth: 1
        )
        
        MessageImageView(imageUrlString: "https://259506.selcdn.ru/sites-static/site701987/563a7e6f-ba06-4394-bca5-eafcc0f55652/563a7e6f-ba06-4394-bca5-eafcc0f55652-5542720.png")
    }
}

//import SwiftUI
//import Kingfisher
//
//struct MessageImageView: View {
//    let imageUrlString: String
//    
//    var body: some View {
//        KFImage(URL(string: imageUrlString))
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(maxWidth: UIScreen.main.bounds.width / 1.5, maxHeight: 360)
//                .clipShape(Rectangle())
//                .cornerRadius(10)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
//                )
//              //  .padding(.horizontal, 10)
//    }
//}
//
//#Preview {
//    MessageImageView(imageUrlString: "https://259506.selcdn.ru/sites-static/site701987/563a7e6f-ba06-4394-bca5-eafcc0f55652/563a7e6f-ba06-4394-bca5-eafcc0f55652-5542720.png")
//}
//
