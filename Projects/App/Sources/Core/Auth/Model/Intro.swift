//
//  Intro.swift
//  ArmMash
//
//  Created by Benji Loya on 20.12.2024.
//

import SwiftUI

// MARK: Intro Model And Sample Intro's
struct Intro: Identifiable{
    var id: String = UUID().uuidString
    var imageName: String
    var title: String
    var subtitle: String
}

var intros: [Intro] = [
    .init(imageName: "Image 1", title: "Hey there! Your new chat space", subtitle: "Chats, friends, and cool communities — all in one place."),
    .init(imageName: "Image 2", title: "Stay connected anywhere", subtitle: "Messages, calls, and live updates — everything you need is here."),
    .init(imageName: "Image 3", title: "Share freely, live worry-free", subtitle: "Share thoughts, photos, and videos with your friends in seconds."),
    .init(imageName: "Image 4", title: "Discover new friends worldwide", subtitle: "Join communities and stay on top of all the latest trends.")
]



// MARK: Intro Model And Sample Intro's
//struct Intro: Identifiable {
//    var id: String = UUID().uuidString
//    var systemImageName: String
//    var title: String
//    var subtitle: String
//}
//
//var intros: [Intro] = [
//    .init(systemImageName: "message.badge.waveform.fill", title: "Hey there! Your new chat space", subtitle: "Chats, friends, and cool communities — all in one place."),
//    .init(systemImageName: "bolt.horizontal.icloud.fill", title: "Stay connected anywhere", subtitle: "Messages, calls, and live updates — everything you need is here."),
//    .init(systemImageName: "paperplane.fill", title: "Share freely, live worry-free", subtitle: "Share thoughts, photos, and videos with your friends in seconds."),
//    .init(systemImageName: "globe.americas.fill", title: "Discover new friends worldwide", subtitle: "Join communities and stay on top of all the latest trends.")
//]


// MARK: Dummy Text
let dummyText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.\nLorem Ipsum is dummy text."


