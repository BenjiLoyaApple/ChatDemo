import SwiftUI
import Feature
import Components

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to ChatDemo")
                    .font(.largeTitle)
                    .padding()

                CustomChatButton(
                    imageName: .systemName("moon"),
                    font: .title,
                    foregroundStyle: .teal,
                    padding: 20
                )
                
                NavigationLink(destination: FeatureView(imageUrl: "https://via.placeholder.com/300")) { // Используем FeatureView
                    Text("Open Feature Module")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.2))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
