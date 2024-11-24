//import Foundation
//import ProjectDescription
//
//public struct ProjectEnvironment {
//    public let name: String
//    public let deploymentTargets: String
//    public let destinations : Destinations
//    public let marketingVersion: String
//    public let currentProjectVersion: String
//    public let baseSetting: SettingsDictionary
//    public let baseConfigurations: [Configuration]
//}
//
//public let env = ProjectEnvironment(
//    name: "ChatApp",
//    deploymentTargets: "17.0",
//    destinations: [.iPhone],
//    marketingVersion: "1.0.3",
//    currentProjectVersion: "007",
//    baseSetting: SettingsDictionary()
//        .debugInformationFormat(DebugInformationFormat.dwarfWithDsym)
//        .otherLinkerFlags(["-ObjC"])
//        .bitcodeEnabled(false),
//    baseConfigurations: [
//        .debug(name: .debug),
//        .release(name: .release)
//    ]
//)
//
//public enum MainTargetType: String {
//    case devices = "devices"
//    case simulators = "simulators"
//    
//    public var name: String {
//        switch self {
//        case .devices:
//            env.name + "-" + self.rawValue
//        case .simulators:
//            env.name + "-" + self.rawValue
//        }
//    }
//    
//    public var bundleIdName: String {
//        "com.benjiloya.ChatMessage"
//    }
//    
//    public var deploymentTargets: DeploymentTargets {
//        .iOS(env.deploymentTargets)
//    }
//    
//    public var destinations: Destinations {
//        env.destinations
//    }
//    
//    public var baseSetting: SettingsDictionary {
//        switch self {
//        case .devices:
//            [
//                "SUPPORTED_PLATFORMS": "iphoneos",
//            ]
//                .marketingVersion(env.marketingVersion)
//                .currentProjectVersion(env.currentProjectVersion)
//                .debugInformationFormat(DebugInformationFormat.dwarfWithDsym)
//                .otherLinkerFlags(["-ObjC"])
//                .bitcodeEnabled(false)
//          //      .automaticCodeSigning(devTeam: "MYASC2LRM6")
//            //    .swiftObjcBridgingHeaderPath("Sources/Library/Objective-C/InfinBank-Bridging-Header.h")
//                .swiftOptimizationLevel(.oNone)
//        case .simulators:
//            [
//                "SUPPORTED_PLATFORMS": "iphonesimulator",
//                "EXCLUDED_ARCHS": "arm64",
//            ]
//                .marketingVersion(env.marketingVersion)
//                .currentProjectVersion(env.currentProjectVersion)
//                .debugInformationFormat(DebugInformationFormat.dwarfWithDsym)
//                .otherLinkerFlags(["-ObjC"])
//                .bitcodeEnabled(false)
//            //    .automaticCodeSigning(devTeam: "MYASC2LRM6")
//             //   .swiftObjcBridgingHeaderPath("Sources/Library/Objective-C/InfinBank-Bridging-Header.h")
//                .swiftOptimizationLevel(.oNone)
//        }
//    }
//}


import ProjectDescription

public extension Project {
    /// Шаблон для создания приложения
    static func app(
        name: String,
        bundleId: String,
        infoPlist: InfoPlist = .default,
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements = ["Resources/**"],
        dependencies: [TargetDependency] = [],
        additionalSettings: SettingsDictionary = [:]
    ) -> Project {
        let debugSettings: SettingsDictionary = [
            "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
            "OTHER_LDFLAGS": ["-ObjC"] // Добавляем флаг
        ]
        let releaseSettings: SettingsDictionary = [
            "SWIFT_OPTIMIZATION_LEVEL": "-Owholemodule",
            "OTHER_LDFLAGS": ["-ObjC"] // Добавляем флаг
        ]

        return Project(
            name: name,
            targets: [
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .app,
                    bundleId: bundleId,
                    infoPlist: infoPlist,
                    sources: sources, // Передаем корректный тип
                    resources: resources, // Передаем корректный тип
                    dependencies: dependencies,
                    settings: .settings(configurations: [
                        .debug(
                            name: "Debug",
                            settings: debugSettings.merging(additionalSettings, uniquingKeysWith: { $1 })
                        ),
                        .release(
                            name: "Release",
                            settings: releaseSettings.merging(additionalSettings, uniquingKeysWith: { $1 })
                        )
                    ])
                ),
                .target(
                    name: "\(name)Tests",
                    destinations: .iOS,
                    product: .unitTests,
                    bundleId: "\(bundleId).Tests",
                    infoPlist: .default,
                    sources: ["Tests/**"],
                    dependencies: [.target(name: name)]
                )
            ]
        )
    }

    /// Шаблон для создания фреймворков
    static func framework(
        name: String,
        bundleIdPrefix: String,
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements = ["Resources/**"],
        includeTests: Bool = false,
        dependencies: [TargetDependency] = [],
        additionalSettings: SettingsDictionary = [:]
    ) -> Project {
        let debugSettings: SettingsDictionary = [
            "OTHER_LDFLAGS": ["-ObjC"] // Добавляем флаг
        ]
        let releaseSettings: SettingsDictionary = [
            "OTHER_LDFLAGS": ["-ObjC"] // Добавляем флаг
        ]

        var targets: [Target] = [
            .target(
                name: name,
                destinations: .iOS,
                product: .framework,
                bundleId: "\(bundleIdPrefix).\(name)",
                infoPlist: .default,
                sources: sources, // Передаем корректный тип
                resources: resources, // Передаем корректный тип
                dependencies: dependencies,
                settings: .settings(configurations: [
                    .debug(
                        name: "Debug",
                        settings: debugSettings.merging(additionalSettings, uniquingKeysWith: { $1 })
                    ),
                    .release(
                        name: "Release",
                        settings: releaseSettings.merging(additionalSettings, uniquingKeysWith: { $1 })
                    )
                ])
            )
        ]

        if includeTests {
            targets.append(
                .target(
                    name: "\(name)Tests",
                    destinations: .iOS,
                    product: .unitTests,
                    bundleId: "\(bundleIdPrefix).\(name)Tests",
                    infoPlist: .default,
                    sources: ["Tests/**"],
                    dependencies: [.target(name: name)]
                )
            )
        }

        return Project(
            name: name,
            targets: targets
        )
    }
}
