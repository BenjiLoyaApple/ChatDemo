import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvironmentPlugin

let project = Project.createProject(
    name: "ChatDemo",
    bundleId: "com.benjiloya.ChatMessage",
    product: .app,
    infoPlist: "Support/Info.plist",
    dependencies: [
        .project(target: "Models", path: "../Models"),
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
