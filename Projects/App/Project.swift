//import ProjectDescription
//import ProjectDescriptionHelpers
//import DependencyPlugin
//import EnvironmentPlugin
//
//let project = Project.createProject(
//    name: "ChatDemo",
//    bundleId: "com.benjiloya.GossipApp",
//    product: .app,
//    infoPlist: "Support/Info.plist",
//    dependencies: [
//        .project(target: "Models", path: "../Models"),
//        .project(target: "Components", path: "../Components"),
//        .SPM.FirebaseAuth,
//        .SPM.FirebaseFirestore,
//        .SPM.FirebaseFirestoreSwift,
//        .SPM.FirebaseStorage,
//        .SPM.SwiftfulUI,
//        .SPM.SwiftfulRouting
//    ],
//    includeSchemes: true,
//    environment: ProjectEnvironment.defaultEnv
//)

import ProjectDescription
import ProjectDescriptionHelpers
import EnvironmentPlugin

let project = Project(
    name: env.name,
    options: Project.Options.options(
        disableBundleAccessors: true,
        disableSynthesizedResourceAccessors: true
    ),
    packages: [],
    
    settings: .settings(
        base: [
            "SDKROOT": "iphoneos",
            "IPHONEOS_DEPLOYMENT_TARGET": "\(env.deploymentTargets)"
        ]
    ),
    targets: [
        .buildTarget(type: .devices),
        .buildTarget(type: .simulators)
    ],
    schemes: [
        .scheme(
            name: "\(env.name)-Release",
            hidden: false,
            buildAction: .buildAction(targets: [.target(MainTargetType.devices.name)]),
            runAction: .runAction(configuration: .release),
            archiveAction: .archiveAction(configuration: .release),
            profileAction: .profileAction(configuration: .release),
            analyzeAction: .analyzeAction(configuration: .release)
        )
    ]
)
