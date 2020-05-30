//
//  PetController.swift
//  App
//
//  Created by Aditya Shinde on 05/05/20.
//

import Vapor

final class PetController {
    
    //Create/Add new pet
    func createNewPet(_ req: Request) throws -> Future<Pet> {
        return try req.content.decode(Pet.self).flatMap { newPet in
            return newPet.save(on: req)
        }
    }
    
    //Get all pets
    func getAllPets(_ req: Request) throws -> Future<[Pet]> {
        return Pet.query(on: req).all()
    }
    
    //update pet
    func updatePet(_ req: Request) throws -> Future<Pet> {
        return try flatMap(to: Pet.self, req.parameters.next(Pet.self), req.content.decode(Pet.self), { pet, updatedPet in
            pet.name = updatedPet.name
            pet.breed = updatedPet.breed
            pet.type = updatedPet.type
            
            return pet.save(on: req)
        })
    }
    
    //delete Pet
    func deletePet(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Pet.self).flatMap { pet in
           return pet.delete(on: req)
        }.transform(to: .ok)
    }
}
