//import ProjectDescription
//
//public struct ProjectEnvironment {
//    public let name: String
//    public let deploymentTargets: String
//    public let marketingVersion: String
//    public let currentProjectVersion: String
//    public let baseSetting: SettingsDictionary
//    public let baseConfigurations: [Configuration]
//
//    public init(
//        name: String,
//        deploymentTargets: String,
//        marketingVersion: String,
//        currentProjectVersion: String,
//        baseSetting: SettingsDictionary,
//        baseConfigurations: [Configuration]
//    ) {
//        self.name = name
//        self.deploymentTargets = deploymentTargets
//        self.marketingVersion = marketingVersion
//        self.currentProjectVersion = currentProjectVersion
//        self.baseSetting = baseSetting
//        self.baseConfigurations = baseConfigurations
//    }
//}
//
//public extension ProjectEnvironment {
//    static var defaultEnv: ProjectEnvironment {
//        return ProjectEnvironment(
//            name: "GossipApp",
//            deploymentTargets: "17.0",
//            marketingVersion: "1.0.0",
//            currentProjectVersion: "1",
//            baseSetting: SettingsDictionary()
//                .debugInformationFormat(DebugInformationFormat.dwarfWithDsym)
//                .otherLinkerFlags(["-ObjC"])
//                .bitcodeEnabled(false),
//            baseConfigurations: [
//                .debug(name: .debug),
//                .release(name: .release)
//            ]
//        )
//    }
//}


import Foundation
import ProjectDescription

public struct ProjectEnvironment {
    public let name: String
    public let deploymentTargets: String
    public let destinations : Destinations
    public let marketingVersion: String
    public let currentProjectVersion: String
    public let baseSetting: SettingsDictionary
    public let baseConfigurations: [Configuration]
}

public let env = ProjectEnvironment(
    name: "Gossip",
    deploymentTargets: "17.0",
    destinations: [.iPhone],
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

public enum MainTargetType: String {
    case devices = "devices"
    case simulators = "simulators"
    
    public var name: String {
        switch self {
        case .devices:
            env.name + "-" + self.rawValue
        case .simulators:
            env.name + "-" + self.rawValue
        }
    }
    
    public var bundleIdName: String {
        "com.benjiloya.ChatMessage"
    }
    
    public var deploymentTargets: DeploymentTargets {
        .iOS(env.deploymentTargets)
    }
    
    public var destinations: Destinations {
        env.destinations
    }
    
    public var baseSetting: SettingsDictionary {
        switch self {
        case .devices:
            [
                "SUPPORTED_PLATFORMS": "iphoneos",
            ]
                .marketingVersion(env.marketingVersion)
                .currentProjectVersion(env.currentProjectVersion)
                .debugInformationFormat(DebugInformationFormat.dwarfWithDsym)
                .otherLinkerFlags(["-ObjC"])
                .bitcodeEnabled(false)
                .automaticCodeSigning(devTeam: "8M6DJXJ8ZE")
                .swiftOptimizationLevel(.oNone)
        case .simulators:
            [
                "SUPPORTED_PLATFORMS": "iphonesimulator",
             //   "EXCLUDED_ARCHS": "arm64",
                "VALID_ARCHS": "x86_64 arm64",
            ]
                .marketingVersion(env.marketingVersion)
                .currentProjectVersion(env.currentProjectVersion)
                .debugInformationFormat(DebugInformationFormat.dwarfWithDsym)
                .otherLinkerFlags(["-ObjC"])
                .bitcodeEnabled(false)
                .automaticCodeSigning(devTeam: "8M6DJXJ8ZE")
                .swiftOptimizationLevel(.oNone)
        }
    }
}
