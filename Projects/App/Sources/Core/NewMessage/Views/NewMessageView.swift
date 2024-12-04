//
//  NewMessageView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.08.2023.
//

import SwiftUI
import SwiftfulRouting
import Components

struct NewMessageView: View {
    @Environment(\.router) var router
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = NewMessageViewModel()
    @Binding var selectedUser: User?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HeaderComponent(backButtonPressed: {
                dismiss()
            }) {
                Spacer(minLength: 0)
                
                Text("New Message")
                    .font(.subheadline)
                    .offset(x: -20)
                
                Spacer(minLength: 0)
            }
            
            ScrollView {
                
                HStack(spacing: 10) {
                    Text("To:")
                    
                    TextField("Search ", text: $viewModel.searchText)
                }
                .foregroundStyle(.gray.opacity(0.8))
                .frame(height: 50)
                .padding(.leading)
                .background(Color.gray.opacity(0.001))
                
                Text("Suggested")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                LazyVStack {
                    ForEach(viewModel.filteredUsers) { user in
                        HStack(spacing: 15) {
                            CircularProfileImageView(user: user, size: .medium50)
                            
                            Text(user.username)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 5)
                        .onTapGesture {
                            selectedUser = user
                            router.showScreen(.push) { _ in
                                ChatView(user: user)
                            }
                        }
                        .padding(.leading)
                    }
                }
            }
        }
        .background(Color.theme.darkBlack)
    }
    
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(selectedUser: .constant(nil))
    }
}
