import ProjectDescription
import EnvironmentPlugin
import DependencyPlugin

let launchScreenInfo: [String: Plist.Value] = [
    "UILaunchScreen": .dictionary([
        "UIColorName": .string("LaunchBackgroundColor"),
        "UIImageName": .string("LaunchImage")
    ])
]

let project = Project.app(
    name: "ChatDemo",
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
