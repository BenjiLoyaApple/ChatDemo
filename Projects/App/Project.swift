import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvironmentPlugin

let launchScreenInfo: [String: Plist.Value] = [
    "UILaunchScreen": .dictionary([
        "UIColorName": .string("LaunchBackgroundColor"),
        "UIImageName": .string("LaunchImage")
    ])
]

let project = Project.createProject(
    name: "ChatDemo",
    bundleId: "com.benjiloya.ChatMessage",
    product: .app,
  //  infoPlist: .extendingDefault(with: launchScreenInfo),
    infoPlist: "Support/Info.plist",
    dependencies: [
        .project(target: "Feature", path: "../Feature"),
        .project(target: "Components", path: "../Components"),
        .SPM.FirebaseAuth,
        .SPM.FirebaseFirestore,
        .SPM.FirebaseFirestoreSwift,
        .SPM.FirebaseStorage,
        .SPM.SwiftfulUI,
        .SPM.SwiftfulRouting
    ],
    environment: ProjectEnvironment.defaultEnv 
)


//import ProjectDescription
//import ProjectDescriptionHelpers
//import DependencyPlugin
////import EnvironmentPlugin
//
//let launchScreenInfo: [String: Plist.Value] = [
//    "UILaunchScreen": .dictionary([
//        "UIColorName": .string("LaunchBackgroundColor"),
//        "UIImageName": .string("LaunchImage")
//    ])
//]
//
//let project = Project.createProject(
//    name: "ChatDemo",
//    bundleId: "com.benjiloya.ChatMessage",
//    product: .app,
//    infoPlist: .extendingDefault(with: launchScreenInfo),
//    dependencies: [
//        .project(target: "Feature", path: "../Feature"),
//        .project(target: "Components", path: "../Components"),
//   //     .SPM.Kingfisher,
//        .SPM.FirebaseAuth,
//        .SPM.FirebaseFirestore,
//        .SPM.FirebaseFirestoreSwift,
//        .SPM.FirebaseStorage,
//        .SPM.SwiftfulUI,
//        .SPM.SwiftfulRouting
//    ]
//)
