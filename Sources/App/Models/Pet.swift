//
//  Pet.swift
//  App
//
//  Created by Aditya Shinde on 03/05/20.
//

import Vapor
import FluentPostgreSQL //1

final class Pet: PostgreSQLUUIDModel { //2
    var id: UUID?
    var type: String
    var breed: String
    var name: String
    
    init(type: String, breed: String, name: String) { //3
        self.type = type
        self.breed = breed
        self.name = name
    }
}

/// Allows `Pet` model/table  to be used as a dynamic parameter in route definitions.
extension Pet: Parameter {} //4

/// Allows `Pet` model/table  to be encoded to and decoded from HTTP messages.
extension Pet: Content {} //5

/// Allows `Pet` model/table to be used as a dynamic parameter in route definitions.
extension Pet: Migration {} //6

