//
//  TwoClasses.swift
//  MemoryManagment
//
//  Created by KamsQue on 08/09/2023.
//

import Foundation

class TestTwoClasses {
  
  func testAllCases() {
      // Test different reference scenarios
      // Creating a retain cycle
    var john: Personal? = Personal(name: "John")
    var apt: Apartment? = Apartment(number: 123)
    
    john?.apartment = apt
    apt?.resident = john
    
      // Both objects now have strong references to each other, creating a retain cycle.
    
      // Setting one reference to nil won't deallocate the objects.
    john = nil
    apt = nil
    
      // The objects are not deallocated due to the retain cycle.
    
    
//    testWeakReference()
//    testStrongReference()
//    testUnownedReference()
  }
  
//  func testWeakReference() {
//    var vehicle: Vehicle? = Vehicle(model: "SUV")
//    var car: Car? = Car(brand: "Toyota")
//    
//      // Establish a weak reference from Car to Vehicle
//    car?.vehicle = vehicle
//    
//      // Simulate deallocation of the Vehicle
//    vehicle = nil
//    
//      // At this point, vehicle is deallocated, and car's weak reference becomes nil
//    print("Car's weak reference to Vehicle: \(car?.vehicle)")
//  }
//  
//  func testStrongReference() {
//    var vehicle: Vehicle? = Vehicle(model: "SUV")
//    var car: Car? = Car(brand: "Toyota")
//    
//      // Establish a strong reference from Car to Vehicle
//    vehicle?.car = car
//    
//      // Simulate deallocation of the Vehicle
//    vehicle = nil
//    
//      // At this point, vehicle is deallocated, but car's strong reference keeps it alive
//    print("Car's strong reference to Vehicle: \(car?.vehicle)")
//  }
//  
//  func testUnownedReference() {
//    var vehicle: Vehicle? = Vehicle(model: "SUV")
//    var car: Car? = Car(brand: "Toyota")
//    
//      // Establish an unowned reference from Car to Vehicle
//    car?.vehicle = vehicle
//    
//      // Simulate deallocation of the Vehicle
//    vehicle = nil
//    
//      // Attempting to access an unowned reference after deallocation is unsafe
//      // Uncomment the next line to see the crash:
//    print("Car's unowned reference to Vehicle: \(car?.vehicle)")
//  }
}


class Personal {
  var name: String
  weak var apartment: Apartment?
  
  init(name: String) {
    self.name = name
    print("Person \(name) allocated")
  }
  
  deinit {
    print("Person \(name) deallocated")
  }
}

class Apartment {
  var number: Int
  var resident: Personal?
  
  init(number: Int) {
    self.number = number
    print("Apartment \(number) allocated")
  }
  
  deinit {
    print("Apartment \(number) deallocated")
  }
}











class Vehicle {
  var car: Car?
  let model: String
  
  init(model: String) {
    self.model = model
    print("Vehicle \(model) allocated")
  }
  
  deinit {
    print("Vehicle \(model) deallocated")
  }
}

class Car {
  var vehicle: Vehicle?
  let brand: String
  
  init(brand: String) {
    self.brand = brand
    print("Car \(brand) allocated")
  }
  
  deinit {
    print("Car \(brand) deallocated")
  }
}



