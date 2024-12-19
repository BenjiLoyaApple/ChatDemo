import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvironmentPlugin

let project = Project.createProject(
    name: "Models",
    bundleId: "io.tuist.Models",
    product: .framework,
    dependencies: [
      //  .SPM.Kingfisher
    ],
    includeTests: false,
    includeSchemes: false,
    environment: ProjectEnvironment.defaultEnv
)
