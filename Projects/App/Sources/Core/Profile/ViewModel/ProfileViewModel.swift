//
//  ProfileViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 10.08.2023.
//

import Foundation
import Combine
import SwiftUI
import PhotosUI
import Firebase

@MainActor
class ProfileViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var currentUser: User? = nil
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    
    @Published var profileImage: Image?
    @Published var username = ""
    @Published var bio = ""
    @Published var link = ""
    @Published var uiImage: UIImage?
    
    //private var uiImage: UIImage?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
        
    init() {
     //   setupSubscribers()
        loadUserData()
    }
    
    func loadCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.currentUser = try await UserService.fetchUser(uid: uid)
    }
  
    
}

// MARK: - User Data
extension ProfileViewModel {
    func loadUserData() {
        guard let user = currentUser else {
            // Fetch current user if not already loaded
            Task {
                do {
                    try await loadCurrentUser()
                    self.username = currentUser?.username ?? ""
                    self.bio = currentUser?.bio ?? ""
                    self.link = currentUser?.link ?? ""
                } catch {
                    print("Error loading user data: \(error)")
                }
            }
            return
        }
        self.username = user.username
        self.bio = user.bio ?? ""
        self.link = user.link ?? ""
    }
    
    func updateUserData() async throws {
        guard let user = currentUser else { return }
        var data: [String: Any] = [:] // Changed to [String: Any] for Firestore

        // Check for changes in username
        if !username.isEmpty, user.username != username {
            currentUser?.username = username
            data["username"] = username
        }

        // Check for changes in bio
        if !bio.isEmpty, user.bio ?? "" != bio {
            currentUser?.bio = bio
            data["bio"] = bio
        }

        // Check for changes in link
        if !link.isEmpty, user.link ?? "" != link {
            currentUser?.link = link
            data["link"] = link
        }

        // Check for changes in profile image
        if let uiImage = uiImage {
            try await updateProfileImage(uiImage)
            if let profileImageUrl = currentUser?.profileImageUrl {
                data["profileImageUrl"] = profileImageUrl
            }
        }

        // Update data in Firestore
        if !data.isEmpty {
            try await FirestoreConstants.UsersCollection.document(user.id).updateData(data)
            // Reload updated user data
            self.currentUser = try await UserService.fetchUser(uid: user.id)
        }
    }
    
    
}

// MARK: - Subscribers
//extension ProfileViewModel {
//    
//    @MainActor
//    private func setupSubscribers() {
//        UserService.shared.$currentUser
//            .sink { [weak self] user in
//                self?.currentUser = user
//                self?.loadUserData() 
//            }
//            .store(in: &cancellables)
//    }
//}

// MARK: - Image Loading
extension ProfileViewModel {
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
        
        do {
            try await updateUserData()
        } catch {
            print("Error updating user data: \(error)")
        }
    }
    
    func updateProfileImage(_ uiImage: UIImage) async throws {
        do {
            let imageUrl = try await ImageUploader.uploadImage(image: uiImage, type: .profile)
            currentUser?.profileImageUrl = imageUrl
            try await FirestoreConstants.UsersCollection.document(currentUser?.id ?? "").updateData([
                "profileImageUrl": imageUrl ?? ""
            ])
        } catch {
            print("Error uploading profile image:", error)
            throw error
        }
    }
    }
