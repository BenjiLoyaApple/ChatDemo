//import ProjectDescription
//import ProjectDescriptionHelpers
//import DependencyPlugin
//import EnvironmentPlugin
//
//let project = Project.createProject(
//    name: "Components",
//    bundleId: "io.tuist.Components",
//    product: .framework,
//    dependencies: [
//        .SPM.Kingfisher
//    ],
//    includeTests: false,
//    includeSchemes: false,
//    environment: ProjectEnvironment.defaultEnv
//)


import ProjectDescription
import ProjectDescriptionHelpers
import EnvironmentPlugin

let project = Project(
    name: "Components",
   // options: .options(automaticSchemesOptions: .enabled),
    settings: .settings(
        base: env.baseSetting,
        configurations: env.baseConfigurations
    ),
    targets: [
        .target(
            name: "Components",
            destinations: env.destinations,
            product: .framework,
            bundleId: "io.tuist.Components",
            deploymentTargets: .iOS(env.deploymentTargets),
            sources: ["Sources/**"],
            dependencies: [
                .SPM.Kingfisher,
//                .SPM.SwiftfulUI,
//                .SPM.SwiftfulRouting
                
            ]
        )
    ]
)
