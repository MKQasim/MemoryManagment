//
//  SingletonManager.swift
//  MemoryManagment
//
//  Created by KamsQue on 08/09/2023.
//

import Foundation

  // Singleton class using a shared instance
class SingletonManagerTester {
  func testAllCases() {
      // Test different reference scenarios for the singleton pattern
    testWeakReference()
    testStrongReference()
    testUnownedReference()
  }
  
  func testWeakReference() {
    var objectWithWeakReference: ObjectWithSingletonReference? = ObjectWithSingletonReference()
    objectWithWeakReference?.performTask()
    
      // In this case, the weak reference allows deallocation of the object
      // Clean up resources as needed
    objectWithWeakReference = nil
  }
  
  func testStrongReference() {
    let objectWithStrongReference: ObjectWithSingletonReference? = ObjectWithSingletonReference()
    objectWithStrongReference?.performTask()
    
      // In this case, the strong reference can lead to a retain cycle
      // Clean up resources as needed
  }
  
  func testUnownedReference() {
    let objectWithUnownedReference: ObjectWithSingletonReference? = ObjectWithSingletonReference()
    objectWithUnownedReference?.performTask()
    
      // In this case, the unowned reference is safe because the singleton outlives the object
      // Clean up resources as needed
  }
}

class SingletonManager {
  static let shared = SingletonManager()
  
  private init() {
      // Private initializer to prevent external instantiation
  }
  
  func doSomething() {
    print("SingletonManager is doing something.")
  }
  
    // Method to reset the singleton (set it to nil)
  static func reset() {
    shared.resetSingleton()
  }
  
  private func resetSingleton() {
      // Reset any necessary properties or perform cleanup
    print("SingletonManager is being reset.")
  }
}

class ObjectWithSingletonReference {
  weak var weakSingleton: SingletonManager?
  unowned var unownedSingleton: SingletonManager
  
  init() {
      // Capture the singleton with both weak and unowned references
    weakSingleton = SingletonManager.shared
    unownedSingleton = SingletonManager.shared
  }
  
  func performTask() {
      // Check if the weak reference is still alive
    if let singleton = weakSingleton {
      singleton.doSomething()
    } else {
      print("Weak reference to SingletonManager is nil.")
    }
    
      // Using an unowned reference is safe here because the singleton
      // is guaranteed to outlive the object
    unownedSingleton.doSomething()
  }
}
