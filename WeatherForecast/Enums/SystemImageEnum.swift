////
////  SystemImageEnum.swift
////  Veersky
////
////  Created by vThink Admin on 08/11/23.
////  Copyright © 2023 Veersky. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//enum SystemImage: Int {
//    case search, settings, close, isLiked, like, play, pause, delete, backUArrow, backArrow, reply, newPost, copy, orderSummaryIcon,
//         shipping, address, phone, forwardArrowIcon, backArrowIcon, upArrowIcon, downArrowIcon, success, error, help, warning,
//         postUpload, share, comment, repost, view, send, message, report, hide, approve, reject, edit, addToCart, cartIcon,
//         takePhoto, selectPhoto, isSelected, cardIcon, appleLogo, scan, videoPause, clear, newMessage, groupIcon, addGroup, pin,
//         moreAction, emoji, microPhone, keyboard, chatIcon, imageIcon, menuUpload, selection, menuIcon, order, interestIcon, home,
//         map, inbox, profile, mapMarkerPost, newTextOnPost, mute, sound, groupMemberIcon, nearByBroadcast, broadcastIcon, connection,
//         queries, calendarIcon
//    
//    var image: UIImage {
//        switch self {
//        case .search: return UIImage(systemName: "magnifyingglass")!
//        case .settings: return UIImage(systemName: "gearshape") ?? UIImage(systemName: "gear")!
//        case .close: return UIImage(systemName: "xmark")!
//        case .isLiked: return UIImage(systemName: "hand.thumbsup.fill")!
//        case .like: return UIImage(systemName: "hand.thumbsup")!
//        case .play: return UIImage(systemName: "play.circle")!
//        case .pause: return UIImage(systemName: "pause.circle")!
//        case .delete: return UIImage(systemName: "trash")!
//        case .backUArrow: return UIImage(systemName: "arrow.uturn.left")!
//        case .backArrow: return UIImage(systemName: "arrow.left")!
//        case .reply: return UIImage(systemName: "arrowshape.turn.up.left")!
//        case .newPost: return UIImage(systemName: "plus.diamond") ?? UIImage(systemName: "plus.app")!
//        case .copy: return UIImage(systemName: "doc.on.doc")!
//        case .orderSummaryIcon: return UIImage(systemName: "doc.plaintext")!
//        case .shipping: return UIImage(systemName: "box.truck") ?? UIImage(systemName: "archivebox")!
//        case .address: return UIImage(systemName: "house")!
//        case .phone: return UIImage(systemName: "iphone.gen2") ?? UIImage(systemName: "iphone") ?? UIImage(systemName: "phone")!
//        case .forwardArrowIcon: return UIImage(systemName: "chevron.right")!
//        case .backArrowIcon: return UIImage(systemName: "chevron.left")!
//        case .upArrowIcon: return UIImage(systemName: "chevron.up")!
//        case .downArrowIcon: return UIImage(systemName: "chevron.down")!
//        case .success: return UIImage(systemName: "checkmark")!
//        case .error: return UIImage(systemName: "multiply")!
//        case .help: return UIImage(systemName: "questionmark")!
//        case .warning: return UIImage(systemName: "exclamationmark")!
//        case .postUpload: return UIImage(systemName: "icloud.and.arrow.up")!
//        case .share: return UIImage(systemName: "square.and.arrow.up")!
//        case .comment: return UIImage(systemName: "message")!
//        case .repost: return UIImage(systemName: "repeat")!
//        case .view: return UIImage(systemName: "eye")!
//        case .send: return UIImage(systemName: "paperplane")!
//        case .message: return UIImage(systemName: "text.bubble")!
//        case .report: return UIImage(systemName: "flag")!
//        case .hide: return UIImage(systemName: "eye.slash")!
//        case .approve: return UIImage(systemName: "person.fill")!
//        case .reject: return UIImage(systemName: "person.crop.square")!
//        case .edit: return UIImage(systemName: "pencil")!
//        case .addToCart: return UIImage(systemName: "cart.badge.plus")!
//        case .cartIcon: return UIImage(systemName: "cart")!
//        case .takePhoto: return UIImage(systemName: "camera")!
//        case .selectPhoto: return UIImage(systemName: "photo.on.rectangle")!
//        case .isSelected: return UIImage(systemName: "checkmark.circle.fill")!
//        case .cardIcon: return UIImage(systemName: "creditcard")!
//        case .appleLogo: return UIImage(systemName: "apple.logo")
//        case .scan: return UIImage(systemName: "camera.fill")!
//        case .videoPause: return UIImage(systemName: "pause")!
//        case .clear: return UIImage(systemName: "xmark.fill")!
//        case .newMessage: return UIImage(systemName: "plus.bubble")!
//        case .groupIcon: return UIImage(systemName: "person.3.fill")!
//        case .addGroup: return UIImage(systemName: "person.2.fill")!
//        case .pin: return UIImage(systemName: "pin")!
//        case .moreAction: return UIImage(systemName: "ellipsis")!
//        case .microPhone: return UIImage(systemName: "mic")!
//        case .keyboard: return UIImage(systemName: "keyboard")!
//        case .emoji: return UIImage(systemName: "face.smiling")!
//        case .chatIcon: return UIImage(systemName: "bubble.left.and.bubble.right")!
//        case .imageIcon: return UIImage(systemName: "photo.on.rectangle.angled") ?? UIImage(systemName: "photo.on.rectangle")!
//        case .menuUpload: return UIImage(systemName: "arrow.triangle.2.circlepath") ?? UIImage(systemName: "arrow.clockwise.icloud")!
//        case .selection: return UIImage(systemName: "circle.fill")!
//        case .menuIcon: return UIImage(systemName: "square.grid.2x2")!
//        case .order: return UIImage(systemName: "bag")!
//        case .interestIcon: return UIImage(systemName: "sparkles")!
//        case .home: return UIImage(systemName: "safari")!
//        case .map: return UIImage(systemName: "map")!
//        case .inbox: return UIImage(systemName: "bubble.left")!
//        case .profile: return UIImage(systemName: "person")!
//        case .mapMarkerPost: return UIImage(systemName: "play.circle.fill")!
//        case .newTextOnPost: return UIImage(systemName: "textformat.size")!
//        case .mute: return UIImage(systemName: "speaker.slash.fill")!
//        case .sound: return UIImage(systemName: "speaker.wave.2.fill")!
//        case .groupMemberIcon: return UIImage(systemName: "person.2")!
//        case .nearByBroadcast: return UIImage(systemName: "antenna.radiowaves.left.and.right")!
//        case .broadcastIcon: return UIImage(systemName: "megaphone")!
//        case .connection: return UIImage(systemName: "plus")!
//        case .queries: return UIImage(systemName: "questionmark.bubble")
//        case .calendarIcon: return UIImage(systemName: "calendar")!
//    
//        }
//    }
//}
