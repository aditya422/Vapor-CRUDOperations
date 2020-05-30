import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    
    //ceate controller object
    let petController = PetController()
    
    //Create
    router.post("pet", use: petController.createNewPet)
    
    //Get all pets
    router.get("pet", use: petController.getAllPets)
    
    //Update pet
    router.put("pet",Pet.parameter, use: petController.updatePet)
    
    //Delete pet
    router.delete("pet",Pet.parameter, use: petController.deletePet)
}
