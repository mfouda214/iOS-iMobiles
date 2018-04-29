//
//  ChecklistItem.swift
//  imobiles
//
//  Created by Mohamed Sobhi  Fouda on 4/29/18.
//  Copyright © 2018 Mohamed Sobhi Fouda. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
    
}
