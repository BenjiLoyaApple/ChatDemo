import ProjectDescription
import EnvironmentPlugin
import DependencyPlugin

let project = Project.framework(
    name: "Feature",
    bundleIdPrefix: "io.tuist",
    includeTests: true,
    dependencies: [
        .SPM.Kingfisher
    ]
)
