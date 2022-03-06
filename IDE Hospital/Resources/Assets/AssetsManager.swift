// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let closeIcon = ImageAsset(name: "closeIcon")
  internal static let fail = ImageAsset(name: "fail")
  internal static let ok = ImageAsset(name: "ok")
  internal static let popupBackground = ImageAsset(name: "PopupBackground")
  internal static let backgroundImage = ImageAsset(name: "backgroundImage")
  internal static let next = ImageAsset(name: "Next")
  internal static let care = ImageAsset(name: "care")
  internal static let fee = ImageAsset(name: "fee")
  internal static let icPin = ImageAsset(name: "ic_pin")
  internal static let icclock = ImageAsset(name: "icclock")
  internal static let icheart = ImageAsset(name: "icheart")
  internal static let life = ImageAsset(name: "life")
  internal static let previous = ImageAsset(name: "previous")
  internal static let rate = ImageAsset(name: "rate")
  internal static let blueCross = ImageAsset(name: "BlueCross")
  internal static let blueDropDownArrow = ImageAsset(name: "BlueDropDownArrow")
  internal static let calendar = ImageAsset(name: "Calendar")
  internal static let companies = ImageAsset(name: "Companies")
  internal static let cross = ImageAsset(name: "Cross")
  internal static let dropDownArrow = ImageAsset(name: "DropDownArrow")
  internal static let email = ImageAsset(name: "Email")
  internal static let emptyCheckBox = ImageAsset(name: "EmptyCheckBox")
  internal static let fees = ImageAsset(name: "Fees")
  internal static let fillCheckBox = ImageAsset(name: "FillCheckBox")
  internal static let password = ImageAsset(name: "Password")
  internal static let phone = ImageAsset(name: "Phone")
  internal static let search = ImageAsset(name: "Search")
  internal static let tabHeart = ImageAsset(name: "TabHeart")
  internal static let user = ImageAsset(name: "User")
  internal static let clock = ImageAsset(name: "clock")
  internal static let doctor = ImageAsset(name: "doctor")
  internal static let emptyHeart = ImageAsset(name: "emptyHeart")
  internal static let emptyStar = ImageAsset(name: "emptyStar")
  internal static let heart = ImageAsset(name: "heart")
  internal static let icClose = ImageAsset(name: "ic_close")
  internal static let pin = ImageAsset(name: "pin")
  internal static let arabicButton = ImageAsset(name: "Arabic Button")
  internal static let english = ImageAsset(name: "English")
  internal static let back2 = ImageAsset(name: "back2")
  internal static let path29 = ImageAsset(name: "path29")
  internal static let settings = ImageAsset(name: "settings")
  internal static let next2 = ImageAsset(name: "Next2")
  internal static let about = ImageAsset(name: "about")
  internal static let calendar2 = ImageAsset(name: "calendar2")
  internal static let contact = ImageAsset(name: "contact")
  internal static let global = ImageAsset(name: "global")
  internal static let heartblue = ImageAsset(name: "heartblue")
  internal static let login = ImageAsset(name: "login")
  internal static let share = ImageAsset(name: "share")
  internal static let sheet = ImageAsset(name: "sheet")
  internal static let user2 = ImageAsset(name: "user2")
  internal static let logo = ImageAsset(name: "Logo")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
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
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
