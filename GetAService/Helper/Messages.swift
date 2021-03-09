//
//  Messages.swift
//  GetAService
//
//  Created by Geek on 09/03/2021.
//

import Foundation
import MessageKit

struct Message : MessageType{
    
    var kind: MessageKind
    
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
}
    

  struct Sender: SenderType {
    public let senderId: String
    public let displayName: String
}
