//
//  item.swift
//  ToDoList
//
//  Created by Alpha.giel DeAsis on 2/23/19.
//  Copyright © 2019 Alpha.giel DeAsis. All rights reserved.
//

import Foundation


class Item: Codable { //mark this class conforming in Encodable,  this means that the item type is now able to encode itself into a P list or into a Jason and for
    
    //TODO: Messages need a messageBody and a sender variable
    var title: String = "";
    var isDone: Bool = false;
}
