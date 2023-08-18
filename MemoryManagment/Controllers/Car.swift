//
//  Car.swift
//  MemoryManagment
//
//  Created by KamsQue on 18/08/2023.
//

import Foundation

class Car {
  var veichle : Veichle?
  let name : String
  init(name: String, veichle: Veichle?) {
    self.name = name
    self.veichle = veichle
    print("\(self) allocated")
  }
  
  deinit {
    print("\(self) De allocated")
  }
  
}
