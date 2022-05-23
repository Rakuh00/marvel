//
//  List.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit

class List {
    
    var characterList: CharacterListModel?

    private static let _sharedInstance = List()
    
    static var sharedInstance: List {
        return _sharedInstance
    }
    
    func syncList(list: List){
        self.characterList = list.characterList
    }

}
