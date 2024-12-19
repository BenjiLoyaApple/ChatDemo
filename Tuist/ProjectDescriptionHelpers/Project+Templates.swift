import ProjectDescription
import EnvironmentPlugin

public extension Project {
    static func createProject(
        name: String,
        bundleId: String,
        product: Product,
        infoPlist: InfoPlist = .default,
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements = ["Resources/**"],
        dependencies: [TargetDependency] = [],
        includeTests: Bool = false,
        includeSchemes: Bool = false, 
        additionalSettings: SettingsDictionary = [:],
        environment: ProjectEnvironment
    ) -> Project {
        let debugSettings: SettingsDictionary = [
            "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
            "OTHER_LDFLAGS": ["-ObjC"],
            "APP_CONFIG": .string("dev"),
            "BASE_URL": .string("https://dev.api.com"),
            "LOG_LEVEL": .string("debug")
        ]
        
        let releaseSettings: SettingsDictionary = [
            "SWIFT_OPTIMIZATION_LEVEL": "-Owholemodule",
            "OTHER_LDFLAGS": ["-ObjC"],
            "APP_CONFIG": .string("prod"),
            "BASE_URL": .string("https://prod.api.com"),
            "LOG_LEVEL": .string("release")
        ]
        
        let settingsWithEnv = environment.baseSetting.merging([
            "MARKETING_VERSION": .string(environment.marketingVersion),
            "CURRENT_PROJECT_VERSION": .string(environment.currentProjectVersion),
            "IPHONEOS_DEPLOYMENT_TARGET": .string(environment.deploymentTargets),
            "APP_NAME": .string(environment.name)
        ], uniquingKeysWith: { $1 })
        
        var targets: [Target] = [
            .target(
                name: name,
                destinations: .iOS,
                product: product,
                bundleId: bundleId,
                infoPlist: infoPlist,
                sources: sources,
                resources: resources,
                dependencies: dependencies,
                settings: .settings(configurations: [
                    .debug(
                        name: "Debug",
                        settings: debugSettings.merging(settingsWithEnv, uniquingKeysWith: { $1 })
                    ),
                    .release(
                        name: "Release",
                        settings: releaseSettings.merging(settingsWithEnv, uniquingKeysWith: { $1 })
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
                    bundleId: "\(bundleId).Tests",
                    infoPlist: .default,
                    sources: ["Tests/**"],
                    dependencies: [.target(name: name)]
                )
            )
        }
        
        // Создаем схемы только при условии includeSchemes == true
        let schemes: [Scheme] = includeSchemes ? [
                   .scheme(
                       name: "\(name)-Debug",
                       shared: true,
                       buildAction: .buildAction(targets: [.target(name)]),
                       runAction: .runAction(configuration: "Debug"),
                       archiveAction: .archiveAction(configuration: "Debug"),
                       profileAction: .profileAction(configuration: "Debug"),
                       analyzeAction: .analyzeAction(configuration: "Debug")
                   ),
                   .scheme(
                       name: "\(name)-Release",
                       shared: true,
                       buildAction: .buildAction(targets: [.target(name)]),
                       runAction: .runAction(configuration: "Release"),
                       archiveAction: .archiveAction(configuration: "Release"),
                       profileAction: .profileAction(configuration: "Release"),
                       analyzeAction: .analyzeAction(configuration: "Release")
                   )
               ] : []
        
        return Project(
            name: name,
            targets: targets,
            schemes: schemes
        )
    }
}
