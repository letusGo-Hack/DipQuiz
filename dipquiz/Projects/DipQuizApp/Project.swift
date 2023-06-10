import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let appName: String = "DipQuiz"

let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleDisplayName": "DipQuizHost",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen"
]

// MARK: - App
let appTargets: [Target] = AppFactory(
    dependency: AppFactory.Dependency(
        appDependencies: [],
        unitTestsDependencies: []
    )
).build(
    payload: AppFactory.Payload(
        bundleID: "com.letusgo.diquiz",
        name: appName,
        platform: .iOS,
        infoPlist: infoPlist
    )
)

// MARK: - Project
let project = ProjectFactory(
    dependency: ProjectFactory.Dependency(
        appTargets: appTargets,
        frameworkTargets: []
    )
).build(
    payload: ProjectFactory.Payload(
        name: appName,
        organizationName: "kr.byunghak"
    )
)

