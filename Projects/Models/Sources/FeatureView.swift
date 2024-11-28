import SwiftUI
import Kingfisher

public struct FeatureView: View {
    let imageUrl: String

    public init(imageUrl: String) {
        self.imageUrl = imageUrl
    }

    public var body: some View {
        VStack {
            Text("Feature Module")
                .font(.headline)
                .padding()

            KFImage(URL(string: imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .shadow(radius: 10)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.blue.opacity(0.2))
    }
}

struct FeatureView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureView(imageUrl: "https://via.placeholder.com/150")
    }
}
