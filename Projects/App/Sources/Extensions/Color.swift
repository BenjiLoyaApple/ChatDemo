//
//  Color.swift
//  ChatApp
//
//  Created by Benji Loya on 16.08.2023.
//

import SwiftUI

extension Color {
    static var theme = ColorTheme()
}

struct ColorTheme {
    let primaryText = Color("PrimaryTextColor")
    let background = Color("BackgroundColor")
    let secondaryBackground = Color("SecondaryBackground")
    
    let primaryBlue = Color("PrimaryBlue")
    let primaryGray = Color("PrimaryGray")
    let primaryGray2 = Color("PrimaryGray2")
    
    
    // chat
    let igChatBG = Color("igChatBG")
    let igChatViolet = Color("igChatViolet")
    let messageImputBG = Color("messageImputBG")
    
    /// colors text & BG
    let darkWhite = Color("darkWhite")
    let darkBlack = Color("darkBlack")
    let primaryBackground = Color("PrimaryBackground")
    
    // Change Theme
    let moon = Color("Moon")
    let sun = Color("Sun")
    let themeBG = Color("ThemeBG")
    
    // in appNotification message icon
    let appNotification = Color("appNotification")
    
    let searchShadow = Color("searchShadow")
    
   
    
    let buttonsCreatePost = Color("buttonsCreatePost")
    let buttonsPostCard = Color("buttonsPostCard")
    let xmark = Color("xmark")
    
    
}
