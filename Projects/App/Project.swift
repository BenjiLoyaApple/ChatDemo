//import ProjectDescription
//
//// Общие параметры для целей
//let defaultBuildSettings: [String: SettingValue] = [
//    "SWIFT_OPTIMIZATION_LEVEL": "-Owholemodule"
//]
//
//let debugReleaseSettings: [String: SettingValue] = [ :
//   // "SWIFT_OPTIMIZATION_LEVEL": "-O0"
//]
//
//// Определение информации для Info.plist
//let launchScreenInfo: [String: Plist.Value] = [
//    "UILaunchScreen": .dictionary([
//        "UIColorName": .string("LaunchBackgroundColor"),  // Укажите свой цвет
//        "UIImageName": .string("LaunchImage")  // Укажите изображение
//    ])
//]
//
//// Цель для основного приложения
//let appTarget: Target = .target(
//    name: "ChatDemo",
//    destinations: .iOS,
//    product: .app,
//    bundleId: "io.tuist.ChatDemo",
//    infoPlist: .extendingDefault(with: launchScreenInfo),
//    sources: ["Sources/**"],
//    resources: ["Resources/**"],
//    dependencies: [
//        .project(target: "Feature", path: "../Feature")
//    ],
//    settings: .settings(configurations: [
//        .debug(name: "Debug", settings: debugReleaseSettings),
//        .release(name: "Release", settings: defaultBuildSettings)
//    ])
//)
//
//// Цель для тестов
//let testTarget: Target = .target(
//    name: "ChatDemoTests",
//    destinations: .iOS,
//    product: .unitTests,
//    bundleId: "io.tuist.ChatDemoTests",
//    infoPlist: .default,
//    sources: ["Tests/**"],
//    resources: [],
//    dependencies: [.target(name: "ChatDemo")],
//    settings: .settings(configurations: [
//        .debug(name: "Debug", settings: debugReleaseSettings),
//        .release(name: "Release", settings: defaultBuildSettings)
//    ])
//)
//
//// Создание проекта с перечислением целей
//let project = Project(
//    name: "ChatDemo",
//    targets: [appTarget, testTarget]
//)


import ProjectDescription
import EnvironmentPlugin
import DependencyPlugin

let launchScreenInfo: [String: Plist.Value] = [
    "UILaunchScreen": .dictionary([
        "UIColorName": .string("LaunchBackgroundColor"), // Укажите свой цвет
        "UIImageName": .string("LaunchImage") // Укажите изображение
    ])
]

let project = Project.app(
    name: "ChatDemo",
  //  bundleId: "io.tuist.ChatDemo",
    bundleId: "com.benjiloya.ChatMessage",
    infoPlist: .extendingDefault(with: launchScreenInfo),
    dependencies: [
        .project(target: "Feature", path: "../Feature"),
        .project(target: "Components", path: "../Components"),
        .SPM.Kingfisher,
        .SPM.FirebaseAuth,
        .SPM.FirebaseFirestore,
        .SPM.FirebaseFirestoreSwift,
        .SPM.FirebaseStorage,
        .SPM.SwiftfulUI,
        .SPM.SwiftfulRouting
    ]
)
