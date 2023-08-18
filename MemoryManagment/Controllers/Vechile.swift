//
//  Vechile.swift
//  MemoryManagment
//
//  Created by KamsQue on 18/08/2023.
//

import Foundation

class Veichle {
  let id : String
  weak var  car : Car?
//  unowned var  car : Car?
//  var  car : Car?
  init(id: String , car: Car?) {
    self.id = id
    self.car = car
    print("\(self) allocated")
  }
  
  deinit {
    print("\(self) De allocated")
  }
}






