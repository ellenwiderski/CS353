//
//  ColorBox.swift
//  colorbox
//
//  Created by Ellen Widerski on 3/29/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import Foundation

struct ColorBox {
    let name: String
    let desc: String
    
    init?(json: Dictionary<String, AnyObject>) {
        guard let name = json["name"] as? String else {
            return nil
        }
        self.name = name
        
        if let desc = json["description"] as? String {
            self.desc = desc
        }
        else {
            self.desc = ""
        }
    }
}