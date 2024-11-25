import ProjectDescription

public struct ProjectEnvironment {
    public let name: String
    public let deploymentTargets: String
    public let marketingVersion: String
    public let currentProjectVersion: String
    public let baseSetting: SettingsDictionary
    public let baseConfigurations: [Configuration]

    public init(
        name: String,
        deploymentTargets: String,
        marketingVersion: String,
        currentProjectVersion: String,
        baseSetting: SettingsDictionary,
        baseConfigurations: [Configuration]
    ) {
        self.name = name
        self.deploymentTargets = deploymentTargets
        self.marketingVersion = marketingVersion
        self.currentProjectVersion = currentProjectVersion
        self.baseSetting = baseSetting
        self.baseConfigurations = baseConfigurations
    }
}

public extension ProjectEnvironment {
    static var defaultEnv: ProjectEnvironment {
        return ProjectEnvironment(
            name: "ChatDemo",
            deploymentTargets: "17.0",
            marketingVersion: "1.0.0",
            currentProjectVersion: "1",
            baseSetting: SettingsDictionary()
                .debugInformationFormat(DebugInformationFormat.dwarfWithDsym)
                .otherLinkerFlags(["-ObjC"])
                .bitcodeEnabled(false),
            baseConfigurations: [
                .debug(name: .debug),
                .release(name: .release)
            ]
        )
    }
}


//import ProjectDescription
//
//public extension Project {
//    // MARK: - Шаблон для создания приложения или фреймворка
//    static func createProject(
//        name: String,
//        bundleId: String,
//        product: Product,
//        infoPlist: InfoPlist = .default,
//        sources: SourceFilesList = ["Sources/**"],
//        resources: ResourceFileElements = ["Resources/**"],
//        dependencies: [TargetDependency] = [],
//        includeTests: Bool = false,
//        additionalSettings: SettingsDictionary = [:]
//    ) -> Project {
//        let debugSettings: SettingsDictionary = [
//            "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
//            "OTHER_LDFLAGS": ["-ObjC"]
//        ]
//        
//        let releaseSettings: SettingsDictionary = [
//            "SWIFT_OPTIMIZATION_LEVEL": "-Owholemodule",
//            "OTHER_LDFLAGS": ["-ObjC"]
//        ]
//        
//        var targets: [Target] = [
//            .target(
//                name: name,
//                destinations: .iOS,
//                product: product,
//                bundleId: bundleId,
//                infoPlist: infoPlist,
//                sources: sources,
//                resources: resources,
//                dependencies: dependencies,
//                settings: .settings(configurations: [
//                    .debug(
//                        name: "Debug",
//                        settings: debugSettings.merging(additionalSettings, uniquingKeysWith: { $1 })
//                    ),
//                    .release(
//                        name: "Release",
//                        settings: releaseSettings.merging(additionalSettings, uniquingKeysWith: { $1 })
//                    )
//                ])
//            )
//        ]
//        
//        // Если нужно, добавляем тесты
//        if includeTests {
//            targets.append(
//                .target(
//                    name: "\(name)Tests",
//                    destinations: .iOS,
//                    product: .unitTests,
//                    bundleId: "\(bundleId).Tests",
//                    infoPlist: .default,
//                    sources: ["Tests/**"],
//                    dependencies: [.target(name: name)]
//                )
//            )
//        }
//
//        return Project(
//            name: name,
//            targets: targets
//        )
//    }
//}
