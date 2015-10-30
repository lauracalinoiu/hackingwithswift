//
//  Person.swift
//  10-NameToFace
//
//  Created by Laura Calinoiu on 29/10/15.
//  Copyright © 2015 3Smurfs. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String

    init(name: String, image: String){
        self.name = name
        self.image = image
    }
}
