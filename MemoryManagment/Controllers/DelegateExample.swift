//
//  DelegateExample.swift
//  MemoryManagment
//
//  Created by KamsQue on 08/09/2023.
//

import Foundation
protocol DelegateProtocol: AnyObject {
  func didSomething()
}

class DelegateExample {
  
  weak var delegate: DelegateProtocol?
  
  func doSomething() {
    delegate?.didSomething() // Using weak reference to avoid retain cycle
  }
}

class DelegateOwner: DelegateProtocol {
  
  let example: DelegateExample
  
  init() {
    example = DelegateExample()
    example.delegate = self
  }
  
  func didSomething() {
    print("DelegateOwner did something")
  }
  
  deinit {
    print("DelegateOwner deallocated")
  }
}
