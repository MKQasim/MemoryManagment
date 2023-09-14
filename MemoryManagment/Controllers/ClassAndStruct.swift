//
//  ClassAndStruct.swift
//  MemoryManagment
//
//  Created by KamsQue on 08/09/2023.
//

import Foundation

class ClassAndStruct {
  
  func testAllCases() {
      // Test different reference scenarios for class and struct
    testWeakReference()
    testStrongReference()
    testUnownedReference()
  }
  
  func testWeakReference() {
    var person: Person? = Person(name: "John")
    var address: Address? = Address(street: "123 Main St", city: "New York", person: person)
    
      // Establish a weak reference from Address to Person
    address?.person = person
    
      // Simulate deallocation of the Person
    person = nil
    
      // At this point, person is deallocated, and address's weak reference becomes nil
    print("Address's weak reference to Person: \(address?.person?.name ?? "nil")")
  }
  
  func testStrongReference() {
    var person: Person? = Person(name: "John")
    var address: Address? = Address(street: "123 Main St", city: "New York", person: person)
    
      // Establish a strong reference from Address to Person
    person?.address = address
    
      // Simulate deallocation of the Person
    person = nil
    
      // At this point, person is deallocated, but address's strong reference keeps it alive
    print("Address's strong reference to Person: \(address?.person?.name ?? "nil")")
  }
  
  func testUnownedReference() {
    var person: Person? = Person(name: "John")
    var address: Address? = Address(street: "123 Main St", city: "New York", person: person!)
    
      // Establish an unowned reference from Address to Person
    address?.person = person!
    
      // Simulate deallocation of the Person
    person = nil
    
      // Attempting to access an unowned reference after deallocation is unsafe
      // Uncomment the next line to see the crash:
      // print("Address's unowned reference to Person: \(address?.person?.name ?? "nil")")
  }
}

class Person {
  var name: String
  var address: Address?
  
  init(name: String, address: Address? = nil) {
    self.name = name
    self.address = address
    print("Person \(name) allocated")
  }
  
  deinit {
    print("Person \(name) deallocated")
  }
}

struct Address {
  var street: String
  var city: String
  var person: Person?
  
  init(street: String, city: String, person: Person?) {
    self.street = street
    self.city = city
    self.person = person
    print("Address \(street), \(city) allocated")
  }
}








