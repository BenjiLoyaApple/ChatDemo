import ProjectDescription
import EnvironmentPlugin

public extension Project {
    // MARK: - Шаблон для создания приложения или фреймворка с использованием ProjectEnvironment
    static func createProject(
        name: String,
        bundleId: String,
        product: Product,
        infoPlist: InfoPlist = .default,
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements = ["Resources/**"],
        dependencies: [TargetDependency] = [],
        includeTests: Bool = false,
        additionalSettings: SettingsDictionary = [:],
        environment: ProjectEnvironment
    ) -> Project {
        let debugSettings: SettingsDictionary = [
            "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
            "OTHER_LDFLAGS": ["-ObjC"]
        ]
        
        let releaseSettings: SettingsDictionary = [
            "SWIFT_OPTIMIZATION_LEVEL": "-Owholemodule",
            "OTHER_LDFLAGS": ["-ObjC"]
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
        
        // Если нужно, добавляем тесты
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
        
        return Project(
            name: name,
          //  settings: .settings(configurations: environment.baseConfigurations),
            targets: targets
        )
    }
}
