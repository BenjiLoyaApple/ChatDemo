import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvironmentPlugin

let project = Project.createProject(
    name: "Components",
    bundleId: "io.tuist.Components",
    product: .framework,
    dependencies: [
        .SPM.Kingfisher
    ],
    includeTests: false,
    environment: ProjectEnvironment.defaultEnv
)
