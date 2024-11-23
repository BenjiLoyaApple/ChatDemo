import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    // MARK: External
    static let Kingfisher = TargetDependency.external(name: "Kingfisher", condition: .when([.ios]))
    
//    static let FirebaseAuth = TargetDependency.external(name: "FirebaseAuth", condition: .when([.ios]))
//    static let FirebaseFirestore = TargetDependency.external(name: "FirebaseFirestore", condition: .when([.ios]))
//    static let FirebaseFirestoreSwift = TargetDependency.external(name: "FirebaseFirestoreSwift", condition: .when([.ios]))
//    static let FirebaseStorage = TargetDependency.external(name: "FirebaseStorage", condition: .when([.ios]))
//    
//    static let SwiftfulUI = TargetDependency.external(name: "SwiftfulUI", condition: .when([.ios]))
//    static let SwiftfulRouting = TargetDependency.external(name: "SwiftfulRouting", condition: .when([.ios]))
}
