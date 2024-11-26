import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvironmentPlugin

let project = Project.createProject(
    name: "Feature",
    bundleId: "io.tuist.Feature",
    product: .framework,
    dependencies: [
        .SPM.Kingfisher
    ],
    includeTests: false,
    environment: ProjectEnvironment.defaultEnv
)
