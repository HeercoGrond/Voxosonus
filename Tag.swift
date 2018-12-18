//
//  Tag.swift
//  Voxosonus
//
//  Created by Heerco Grond on 18/12/2018.
//  Copyright © 2018 Heerco Grond. All rights reserved.
//

import Foundation

/**
 The Tag class is an intermediate object to control the dictionary. For future expansion of functionality of a Tag within the system, like counting, this class has been created instead of simply leveraging a string.
 */
public class Tag {
    
    private var _tagLabel: String!
    
    public init(tagname: String){
        _tagLabel = tagname
    }
    
    /**
     Returns the value of the Tag.
     */
    public var value: String {
        set { _tagLabel = newValue }
        get { return _tagLabel }
    }
}
