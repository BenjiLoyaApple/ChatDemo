import ProjectDescription

public extension Project {
    // MARK: - Основные конфигурации
    static func baseSettings() -> SettingsDictionary {
        ["OTHER_LDFLAGS": ["-ObjC"]]
    }

    static func optimizationSettings() -> (debug: SettingsDictionary, release: SettingsDictionary) {
        let debugSettings: SettingsDictionary = [
            "SWIFT_OPTIMIZATION_LEVEL": "-Onone"
        ].merging(baseSettings(), uniquingKeysWith: { $1 })

        let releaseSettings: SettingsDictionary = [
            "SWIFT_OPTIMIZATION_LEVEL": "-Owholemodule"
        ].merging(baseSettings(), uniquingKeysWith: { $1 })

        return (debug: debugSettings, release: releaseSettings)
    }

    static func app(
        name: String,
        bundleId: String,
        infoPlist: InfoPlist = .default,
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements = ["Resources/**"],
        dependencies: [TargetDependency] = [],
        includeTests: Bool = true,
        testSources: SourceFilesList = ["Tests/**"],
        additionalSettings: SettingsDictionary = [:]
    ) -> Project {
        let (debugSettings, releaseSettings) = optimizationSettings()

        var targets: [Target] = [
            .target(
                name: name,
                destinations: .iOS,
                product: .app,
                bundleId: bundleId,
                infoPlist: infoPlist,
                sources: sources,
                resources: resources,
                dependencies: dependencies,
                settings: .settings(configurations: [
                    .debug(name: "Debug", settings: debugSettings.merging(additionalSettings, uniquingKeysWith: { $1 })),
                    .release(name: "Release", settings: releaseSettings.merging(additionalSettings, uniquingKeysWith: { $1 }))
                ])
            )
        ]

        if includeTests {
            targets.append(
                .target(
                    name: "\(name)Tests",
                    destinations: .iOS,
                    product: .unitTests,
                    bundleId: "\(bundleId).Tests",
                    infoPlist: .default,
                    sources: testSources,
                    dependencies: [.target(name: name)]
                )
            )
        }

        return Project(
            name: name,
            targets: targets
        )
    }

    static func framework(
        name: String,
        bundleIdPrefix: String,
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements = ["Resources/**"],
        includeTests: Bool = false,
        testSources: SourceFilesList = ["Tests/**"],
        dependencies: [TargetDependency] = [],
        additionalSettings: SettingsDictionary = [:]
    ) -> Project {
        let (debugSettings, releaseSettings) = optimizationSettings()

        var targets: [Target] = [
            .target(
                name: name,
                destinations: .iOS,
                product: .framework,
                bundleId: "\(bundleIdPrefix).\(name)",
                infoPlist: .default,
                sources: sources,
                resources: resources,
                dependencies: dependencies,
                settings: .settings(configurations: [
                    .debug(name: "Debug", settings: debugSettings.merging(additionalSettings, uniquingKeysWith: { $1 })),
                    .release(name: "Release", settings: releaseSettings.merging(additionalSettings, uniquingKeysWith: { $1 }))
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
                    sources: testSources,
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

//import ProjectDescription
//
//public extension Project {
//    //MARK: - Шаблон для создания приложения
//    static func app(
//        name: String,
//        bundleId: String,
//        infoPlist: InfoPlist = .default,
//        sources: SourceFilesList = ["Sources/**"],
//        resources: ResourceFileElements = ["Resources/**"],
//        dependencies: [TargetDependency] = [],
//        additionalSettings: SettingsDictionary = [:]
//    ) -> Project {
//        let debugSettings: SettingsDictionary = [
//            "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
//            "OTHER_LDFLAGS": ["-ObjC"] 
//        ]
//        let releaseSettings: SettingsDictionary = [
//            "SWIFT_OPTIMIZATION_LEVEL": "-Owholemodule",
//            "OTHER_LDFLAGS": ["-ObjC"]
//        ]
//
//        return Project(
//            name: name,
//            targets: [
//                .target(
//                    name: name,
//                    destinations: .iOS,
//                    product: .app,
//                    bundleId: bundleId,
//                    infoPlist: infoPlist,
//                    sources: sources,
//                    resources: resources,
//                    dependencies: dependencies,
//                    settings: .settings(configurations: [
//                        .debug(
//                            name: "Debug",
//                            settings: debugSettings.merging(additionalSettings, uniquingKeysWith: { $1 })
//                        ),
//                        .release(
//                            name: "Release",
//                            settings: releaseSettings.merging(additionalSettings, uniquingKeysWith: { $1 })
//                        )
//                    ])
//                ),
//                .target(
//                    name: "\(name)Tests",
//                    destinations: .iOS,
//                    product: .unitTests,
//                    bundleId: "\(bundleId).Tests",
//                    infoPlist: .default,
//                    sources: ["Tests/**"],
//                    dependencies: [.target(name: name)]
//                )
//            ]
//        )
//    }
//
//    //MARK: - Шаблон для создания фреймворков
//    static func framework(
//        name: String,
//        bundleIdPrefix: String,
//        sources: SourceFilesList = ["Sources/**"],
//        resources: ResourceFileElements = ["Resources/**"],
//        includeTests: Bool = false,
//        dependencies: [TargetDependency] = [],
//        additionalSettings: SettingsDictionary = [:]
//    ) -> Project {
//        let debugSettings: SettingsDictionary = [
//            "OTHER_LDFLAGS": ["-ObjC"]
//        ]
//        let releaseSettings: SettingsDictionary = [
//            "OTHER_LDFLAGS": ["-ObjC"]
//        ]
//
//        var targets: [Target] = [
//            .target(
//                name: name,
//                destinations: .iOS,
//                product: .framework,
//                bundleId: "\(bundleIdPrefix).\(name)",
//                infoPlist: .default,
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
//        if includeTests {
//            targets.append(
//                .target(
//                    name: "\(name)Tests",
//                    destinations: .iOS,
//                    product: .unitTests,
//                    bundleId: "\(bundleIdPrefix).\(name)Tests",
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
