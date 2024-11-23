import ProjectDescription

extension Project {
    /// Шаблон для создания фреймворков с дополнительными настройками
    public static func featureFramework(
        name: String,
        destinations: Destinations = [.iPhone],
        product: Product = .framework,
        dependencies: [TargetDependency] = [],
        includeTests: Bool = false, // Параметр для включения тестов
        infoPlist: InfoPlist = .default, // Параметр для Info.plist
        testsSources: String = "Tests/**", // Параметр для источников тестов
        bundleIdPrefix: String = "com.example", // Префикс для BundleId
        buildSettings: [String: SettingValue] = [:] // Параметры для настроек сборки
    ) -> Project {
        var targets: [Target] = [
            .target(
                name: name,
                destinations: destinations,
                product: product,
                bundleId: "\(bundleIdPrefix).\(name)",
                infoPlist: infoPlist,
                sources: ["Sources/**"],
                resources: ["Resources/**"],
                dependencies: dependencies,
                settings: .settings(configurations: [
                    .debug(name: "Debug", settings: buildSettings),
                    .release(name: "Release", settings: buildSettings)
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
                    dependencies: [.target(name: name)],
                    settings: .settings(configurations: [
                        .debug(name: "Debug", settings: buildSettings),
                        .release(name: "Release", settings: buildSettings)
                    ])
                )
            )
        }
        
        return Project(
            name: name,
            targets: targets
        )
    }
}
