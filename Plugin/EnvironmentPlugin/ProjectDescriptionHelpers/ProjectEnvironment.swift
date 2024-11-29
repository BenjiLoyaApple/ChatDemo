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
