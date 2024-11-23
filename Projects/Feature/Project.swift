//import ProjectDescription
//import ProjectDescriptionHelpers
//import DependencyPlugin
//
//let project = Project.featureFramework(
//    name: "Feature",
//    product: .framework,
//    dependencies: [
//        .SPM.Kingfisher
//    ],
//    includeTests: true,
//  //  infoPlist: .extendingDefault(with: ["UILaunchScreen": ["UIColorName": "blue"]]),
//    testsSources: "Tests/**"
//  //  bundleIdPrefix: "com.mycompany",
//   // buildSettings: [
//   //     "SWIFT_OPTIMIZATION_LEVEL": "-Owholemodule"
//  //  ]
//)


import ProjectDescription
import EnvironmentPlugin
import DependencyPlugin

let project = Project.framework(
    name: "Feature",
    bundleIdPrefix: "io.tuist",
    includeTests: true,
    dependencies: [
        .SPM.Kingfisher
    ]
)
