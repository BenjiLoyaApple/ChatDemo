import ProjectDescription

let workspace = Workspace(
    name: "ChatDemo",
    projects: [
        "Projects/App",    // Указываем новый путь к приложению
        "Projects/Feature", // Другие модули остаются на месте
        "Projects/Components"
    ]
)
