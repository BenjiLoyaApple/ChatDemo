// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum GossipAppAsset: Sendable {
  public enum Assets {
  public static let accentColor = GossipAppColors(name: "AccentColor")
    public static let primaryBackground = GossipAppColors(name: "PrimaryBackground")
    public static let moon = GossipAppColors(name: "Moon")
    public static let sun = GossipAppColors(name: "Sun")
    public static let themeBG = GossipAppColors(name: "ThemeBG")
    public static let appNotification = GossipAppColors(name: "appNotification")
    public static let buttonsCreatePost = GossipAppColors(name: "buttonsCreatePost")
    public static let buttonsPostCard = GossipAppColors(name: "buttonsPostCard")
    public static let darkBlack = GossipAppColors(name: "darkBlack")
    public static let darkWhite = GossipAppColors(name: "darkWhite")
    public static let igChatBG = GossipAppColors(name: "igChatBG")
    public static let igChatViolet = GossipAppColors(name: "igChatViolet")
    public static let messageImputBG = GossipAppColors(name: "messageImputBG")
    public static let searchShadow = GossipAppColors(name: "searchShadow")
    public static let xmark = GossipAppColors(name: "xmark")
    public static let backgroundColor = GossipAppColors(name: "BackgroundColor")
    public static let primaryBlue = GossipAppColors(name: "PrimaryBlue")
    public static let primaryGray = GossipAppColors(name: "PrimaryGray")
    public static let primaryGray2 = GossipAppColors(name: "PrimaryGray2")
    public static let primaryTextColor = GossipAppColors(name: "PrimaryTextColor")
    public static let secondaryBackground = GossipAppColors(name: "SecondaryBackground")
    public static let edit = GossipAppImages(name: "edit")
    public static let gallery = GossipAppImages(name: "gallery")
    public static let pen = GossipAppImages(name: "pen")
    public static let intro = GossipAppImages(name: "Intro")
    public static let apple = GossipAppImages(name: "apple")
    public static let facebook = GossipAppImages(name: "facebook")
    public static let google = GossipAppImages(name: "google")
    public static let instagram = GossipAppImages(name: "instagram")
    public static let welcome = GossipAppImages(name: "Welcome")
    public static let nullProfile = GossipAppImages(name: "nullProfile")
  }
  public enum PreviewAssets {
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class GossipAppColors: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  public var color: Color {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIColor: SwiftUI.Color {
      return SwiftUI.Color(asset: self)
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension GossipAppColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: GossipAppColors) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Color {
  init(asset: GossipAppColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct GossipAppImages: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Image {
  init(asset: GossipAppImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: GossipAppImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: GossipAppImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
