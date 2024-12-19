//
//  GlobalSettings.swift
//  ConfigTest
//
//  Created by Benji Loya on 25.10.2024.
//

import Foundation

enum BuildEnvironment: String {
    case dev
//    case qa
//    case staging
    case prod
}

//MARK: - Build Configuration Variables
enum GlobalSettings {
    static let environment: BuildEnvironment = {
        guard let rawEnvironment = Bundle.main.infoDictionary!["APP_CONFIG"] as? String,
              let environment = BuildEnvironment(rawValue: rawEnvironment) else {
            preconditionFailure("APP_CONFIG cannot be nil")
        }
                
        return environment
    }()
    
    static let baseApiPath: String = {
        guard let path = Bundle.main.infoDictionary!["BASE_URL"] as? String else {
            preconditionFailure("BASE_URL cannot be nil")
        }
        return path
    }()
    
    static private let logLevelBuildConfigSettings: String = {
        guard let level = Bundle.main.infoDictionary!["LOG_LEVEL"] as? String else {
            preconditionFailure("LOG_LEVEL cannot be nil")
        }
        return level
    }()
}

//MARK: - Environment Variables
extension GlobalSettings {
    static var forcceSubscribedState: Bool {
        let key = "FORCE_SUBSCRIBE"
        guard ProcessInfo.processInfo.environment.contains(where: { $0.key == key }) else { return false }
        return ProcessInfo.processInfo.environment[key] == "true"
    }
    
    static private var logLevelEnvironmentVariable: String? {
        let key = "LOG_LEVEL"
        guard ProcessInfo.processInfo.environment.contains(where: { $0.key == key }) else { return nil }
        return ProcessInfo.processInfo.environment[key]
    }
    
}

//MARK: - Environment Variables
extension GlobalSettings {
    static var logLevel: String {
        logLevelEnvironmentVariable ?? logLevelBuildConfigSettings
    }
}

