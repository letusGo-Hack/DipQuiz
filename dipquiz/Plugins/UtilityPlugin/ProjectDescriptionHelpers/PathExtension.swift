import Foundation
import ProjectDescription

public typealias Dep = TargetDependency

extension ProjectDescription.Path {
    public static func relativeToModule(_ pathString: String) -> Self {
        return .relativeToRoot("Projects/Modules/\(pathString)")
    }
    public static var app: Self {
        return .relativeToRoot("Projects/Applicaiton")
    }
}

// MARK: Extension
extension Dep {
    static func module(name: String) -> Self {
        return .project(target: name, path: .relativeToModule(name))
    }
}

// MARK: Project
extension Dep {
    public struct Project {}
}

extension Dep.Project {
    public static let DIKit             = Dep.module(name: "DIKit")
    public static let DataKit           = Dep.module(name: "DataKit")
    public static let DomainKit         = Dep.module(name: "DomainKit")
    public static let FoundationKit     = Dep.module(name: "FoundationKit")
    public static let PresentationKit   = Dep.module(name: "PresentationKit")
    public static let ThirdPartyManager = Dep.module(name: "ThirdPartyManager")
}
