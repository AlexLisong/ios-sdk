//
//  UserProfile.swift
//  DappleySwift
//
//  Created by Li Song on 2018-11-02.
//  Copyright © 2018 Li Song. All rights reserved.
//

import Foundation

public struct UserProfile {
    /// The user id.
    public let userId: String
    
    /// A URL to the user's profile.
    public let profileURL: URL?
    
    
    /**
     Creates a new instance of `Profile`.
     - parameter userId: The user id.
     - parameter profileURL: Optional user's profile URL.
     */
    public init(userId: String,
                profileURL: URL? = nil) {
        self.userId = userId
        self.profileURL = profileURL
    }
    public func display() -> String{
        return self.userId
    }
    //--------------------------------------
    // MARK: - Loading Profile
    //--------------------------------------
   
    /**
     Fetches a user profile by userId.
     If the `current` profile is set, and it has the same `userId`,
     calling method will reset the current profile with the newly fetched one.
     - parameter userId: Facebook user id of the profile to fetch.
     */
    public static func fetch(userId: String) {

    }
}
    
