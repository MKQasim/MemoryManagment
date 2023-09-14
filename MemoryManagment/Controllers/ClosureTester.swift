//
//  ClosureTester.swift
//  MemoryManagment
//
//  Created by KamsQue on 08/09/2023.
//

import Foundation

class ClosureTester {
  var closureA: (() -> Void)?
  var closureB: (() -> Void)?
  var loopCount: Int = 0
  let maxLoopCount: Int = 2
  
  init() {
    print("ClosureTester initialized")
  }
  
  deinit {
    print("ClosureTester deinitialized")
  }
  
    // MARK: - Test All Cases
  
  func testAllCases() {
    print("Testing Weak Reference:")
    testWeakReference()
//    print("\nTesting Strong Reference:")
//    testStrongReference()
    print("\nTesting Unowned Reference:")
    testUnownedReference()
  }
  
    // MARK: - Weak Reference Test
  
  func testWeakReference() {
    closureA = { [weak self] in
      print("Weak Reference - Closure A executed")
      if self?.loopCount ?? 0 < self?.maxLoopCount ?? 0 {
        self?.loopCount += 1
        self?.closureB?()
      }
    }
    
    closureB = { [weak self] in
      print("Weak Reference - Closure B executed")
      if self?.loopCount ?? 0 < self?.maxLoopCount ?? 0 {
        self?.loopCount += 1
        self?.closureA?()
      }
    }
    
    closureA?()
  }
  
    // MARK: - Strong Reference Test
  
  func testStrongReference() {
    var strongSelf: ClosureTester? = self // Create a strong reference to self
    
    closureA = { [weak self] in
      guard let strongSelf = self else {
        print("Strong Reference - Closure A executed (self is nil)")
        return
      }
      print("Strong Reference - Closure A executed")
      strongSelf.closureB?()
    }
    
    closureB = { [weak self] in
      guard let strongSelf = self else {
        print("Strong Reference - Closure B executed (self is nil)")
        return
      }
      print("Strong Reference - Closure B executed")
      strongSelf.closureA?()
    }
    
    closureA?()
    
      // Check for the retain cycle
    if strongSelf == nil {
      print("self has been deallocated; no retain cycle")
    } else {
      print("Retain cycle may exist")
    }
    
    strongSelf = nil // Release the strong reference to self
  }
  
    // ...
  
    // MARK: - Unowned Reference Test
  
  func testUnownedReference() {
    closureA = { [unowned self] in
      print("Unowned Reference - Closure A executed")
      self.loopCount += 1
      if self.loopCount < self.maxLoopCount {
        self.closureB?()
      }
    }
    
    closureB = { [unowned self] in
      print("Unowned Reference - Closure B executed")
      self.loopCount += 1
      if self.loopCount < self.maxLoopCount {
        self.closureA?()
      }
    }
    
    closureA?()
  }
}


