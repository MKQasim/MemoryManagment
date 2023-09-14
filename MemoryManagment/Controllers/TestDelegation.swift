//
//  TestDelegation.swift
//  MemoryManagment
//
//  Created by KamsQue on 08/09/2023.
//

import Foundation

protocol DelegationProtocol: AnyObject {
  func didReceiveData(data: String)
}

  // MARK: - Class Example

class ClassDelegator {
  weak var delegate: DelegationProtocol?
  
  func fetchData() {
    let data = "Class data"
    delegate?.didReceiveData(data: data)
  }
  
  init() {
    print("ClassDelegator allocated")
  }
  
  deinit {
    print("ClassDelegator deallocated")
  }
}

  // MARK: - Struct Example

struct StructDelegator {
  weak var delegate: DelegationProtocol?
  
  func fetchData() {
    let data = "Struct data"
    delegate?.didReceiveData(data: data)
  }
  
  func cleanup() {
    print("StructDelegator deallocated")
  }
}

  // MARK: - Closure Example

class ClosureDelegator {
  var delegate: (() -> Void)?
  var executionCount = 0 // Add a counter
  
  func fetchData() {
    if executionCount < 2 { // Limit the execution to 2 times
      delegate?()
      executionCount += 1
    }
  }
  
  init() {
    print("ClosureDelegator allocated")
  }
  
  deinit {
    print("ClosureDelegator deallocated")
  }
}



class ClassDelegate: DelegationProtocol {
  func didReceiveData(data: String) {
    print("Class Delegate Received: \(data)")
  }
  
  init() {
    print("ClassDelegate allocated")
  }
  
  deinit {
    print("ClassDelegate deallocated")
  }
}


class TestDelegation {
  static var objectCount = 0
  
  init() {
    TestDelegation.objectCount += 1
    print("TestDelegation allocated (\(TestDelegation.objectCount) objects)")
  }
  
  deinit {
    TestDelegation.objectCount -= 1
    print("TestDelegation deallocated (\(TestDelegation.objectCount) objects)")
  }
  
  func testAllCases() {
    testWeakReference()
    testStrongReference()
//    testUnownedReference()
  }
  
  func testWeakReference() {
      // MARK: - Class Delegation with Weak Reference
    let classDelegate = ClassDelegate()
    let classDelegator = ClassDelegator()
    classDelegator.delegate = classDelegate
    classDelegator.fetchData()
    
      // MARK: - Struct Delegation with Weak Reference
    let structDelegate = ClassDelegate() // Reusing ClassDelegate for struct example
    var structDelegator = StructDelegator()
    structDelegator.delegate = structDelegate
    structDelegator.fetchData()
    
      // MARK: - Closure Delegation with Weak Reference
    var closureDelegator: ClosureDelegator? = ClosureDelegator()
    var closureDelegate: (() -> Void)?
    var loopCount = 0
    let maxLoopCount = 2 // Set the maximum allowed execution count
    
      // Set up the closure delegate to execute up to maxLoopCount times
    closureDelegate = { [weak closureDelegator] in
      guard loopCount < maxLoopCount else {
        print("Reached the limit of Closure Delegate execution")
        return
      }
      print("Closure Delegate Received (Weak)")
      loopCount += 1
    }
    
    closureDelegator?.delegate = closureDelegate
    
      // Call fetchData() once, which will invoke the closure
    closureDelegator?.fetchData()
    
      // Ensure that closureDelegator is deallocated
    closureDelegator = nil
  }



  
  func testStrongReference() {
      // MARK: - Class Delegation with Strong Reference
    let classDelegate = ClassDelegate()
    let classDelegatorStrong = ClassDelegator()
    classDelegatorStrong.delegate = classDelegate
    classDelegatorStrong.fetchData()
    
      // MARK: - Struct Delegation with Strong Reference
    var structDelegatorStrong = StructDelegator()
    let structDelegate = ClassDelegate() // Reusing ClassDelegate for struct example
    structDelegatorStrong.delegate = structDelegate
    structDelegatorStrong.fetchData()
    
      // MARK: - Closure Delegation with Strong Reference
    var closureDelegatorStrong: ClosureDelegator? = ClosureDelegator()
    var closureDelegateStrong: () -> Void = {
      print("Closure Delegate Received (Strong)")
      closureDelegatorStrong?.fetchData()
    }
    closureDelegatorStrong?.delegate = closureDelegateStrong
    closureDelegatorStrong?.fetchData()
  }
  
  func testUnownedReference() {
      // MARK: - Class Delegation with Unowned Reference
    let classDelegate = ClassDelegate()
    let classDelegatorUnowned = ClassDelegator()
    classDelegatorUnowned.delegate = classDelegate
    classDelegatorUnowned.fetchData()
    
      // MARK: - Struct Delegation with Unowned Reference
    var structDelegatorUnowned = StructDelegator()
    let structDelegate = ClassDelegate() // Reusing ClassDelegate for struct example
    structDelegatorUnowned.delegate = structDelegate
    structDelegatorUnowned.fetchData()
    
      // MARK: - Closure Delegation with Unowned Reference
    var closureDelegatorUnowned: ClosureDelegator? = ClosureDelegator()
    var closureDelegateUnowned: () -> Void = {
      print("Closure Delegate Received (Unowned)")
      closureDelegatorUnowned?.fetchData()
    }
    closureDelegatorUnowned?.delegate = closureDelegateUnowned
    closureDelegatorUnowned?.fetchData()
  }
}

//let testDelegation: TestDelegation? = TestDelegation()
//testDelegation?.testAllCases()
//testDelegation = nil // Cleanup

