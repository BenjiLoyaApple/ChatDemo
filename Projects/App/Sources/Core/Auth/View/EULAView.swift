//
//  EULAView.swift
//  ChatDemo
//
//  Created by Benji Loya on 24.12.2024.
//

import SwiftUI

struct EULAView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var isEULAagreed: Bool
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.clear)
                .frame(height: 20)
            
            // Прокручиваемый текст EULA
            ScrollView(.vertical, showsIndicators: true) {
                Text("End User License Agreement (EULA)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding()

                Text("""
                    By using this application, you agree to the following terms:

                    1. **Prohibited Content:** You must not upload, share, or create any content that is offensive, discriminatory, obscene, or violates the rights of others.

                    2. **Abusive Behavior:** Abusive or threatening behavior towards other users or administrators is strictly prohibited.

                    3. **Content Moderation:** We reserve the right to remove any objectionable content and suspend or ban users who violate these terms.

                    4. **Reporting:** Users have the ability to report objectionable content, and we commit to resolving these reports within 24 hours.

                    5. **Liability:** The app is provided 'as-is,' and we are not liable for user-generated content or third-party interactions.

                    If you do not agree to these terms, you must not use this application.
                """)
                .font(.callout)
                .padding(.horizontal)
            }

            Spacer()

            // Кнопка принятия условий
            Button(action: {
                isEULAagreed = true
                dismiss()
            }) {
                Text("I Agree")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
        }
        .background(Color.theme.darkBlack)
    }
}

struct EULAView_Previews: PreviewProvider {
    static var previews: some View {
        EULAView(isEULAagreed: .constant(false))
    }
}
