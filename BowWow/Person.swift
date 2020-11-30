//
//  Person.swift
//  BowWow
//
//  Created by Burri, Luke on 2020-11-27.
//

import Foundation

// by adhering to the codable protocol,
// this means an instance of Person can
//be converted to a JSON file

//by adhering to the identifiable protocool,
//each person can be uniquely identified
// this 
struct Person: Codable, Identifiable {
    var name: String
    var id: Int
}

struct People: Codable {
    var sheet1: [Person]
    
}
