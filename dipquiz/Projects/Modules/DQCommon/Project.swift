//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Ever on 2023/06/10.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let frameworkName: String = "DQCommon"

let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleDisplayName": "DipQuizHost",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen"
]

// MARK: - App
let frameworkTargets: [Target] = FrameworkFactory(dependency: FrameworkFactory.Dependency(
    frameworkDependencies: [],
    unitTestsDependencies: []
)).build(payload: FrameworkFactory.Payload(
    name: frameworkName,
    platform: .iOS, product: .framework))


// MARK: - Project
let project = ProjectFactory(
    dependency: ProjectFactory.Dependency(
        appTargets: [],
        frameworkTargets: frameworkTargets
    )
).build(
    payload: ProjectFactory.Payload(
        name: frameworkName,
        organizationName: "kr.byunghak"
    )
)

