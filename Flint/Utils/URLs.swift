//
//  URLs.swift
//  Flint
//
//  Created by MILAD on 4/10/18.
//  Copyright © 2018 MILAD. All rights reserved.
//

import Foundation

class URLs {
    
    static let server = "http://46.165.237.171/web/index.php?r=flint/"
    
    static let imgServer = "http://46.165.237.171/web/img/"
    
    static let login = server + "login"
    
    static let register = server + "register"
    
    static let forgotPassword = server + "forget-password"
    
    static let changePassword = server + "change-password"
    
    static let resetPassword = server + "reset-password"
    
    static let activeUser = server + "active_user"
    
    static let resendActivationCode = server + "resend-activation-code"
    
    static let updateUserLocation = server + "update-user-location"
    
    static let changeUserSettings = server + "change-user-settings"
    
    static let getUserSettings = server + "get-user-settings"
    
    static let deleteAccount = server + "delete-account"
    
    static let editUserInfo = server + "edit-user-info"
    
    static let uploadImage = server + "upload-image"
    
    static let createInvitation = server + "create-invitation"
    
    static let acceptInvite = server + "accept-invite"
    
    static let openLighter = server + "open-lighter"
    
    static let getNearetsLighter = server + "get-nearest-lighter"
    
    static let fireLighter = server + "fire-lighter"
    
    static let getUsersListForInvite = server + "get-users-list-for-invite"
    
    static let likePersonForInvite = server + "like-person-for-invite"
    
    static let superlikeForInvite = server + "superlike-person-for-invite"
    
    static let getConfirmListForInvite = server + "get-confirm-list"
    
    static let confirmUser = server + "confirm-user"
    
    static let reportUser = server + "report-user"
    
    static let afterDatePoll = server + "date-poll"
    
    static let getPartyPeopleAfterParty = server + "get-party-people"
    
    static let matchPartyPeople = server + "match-party-people"
    
    static let getInviteInfo = server + "get-invite-info"
    
    static let getMyInvites = server + "get-my-invites"
    
}
