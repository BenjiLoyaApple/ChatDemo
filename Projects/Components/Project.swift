import ProjectDescription
import EnvironmentPlugin
import DependencyPlugin

let project = Project.framework(
    name: "Components",
    bundleIdPrefix: "io.tuist",
    includeTests: false,
    dependencies: [
      //  .SPM.Kingfisher
    ]
)

