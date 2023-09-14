//
//  ViewController.swift
//  MemoryManagment
//
//  Created by KamsQue on 18/08/2023.
//

import UIKit


//* Class and Class with a Circular Reference:
//* Two classes that reference each other.

//* For example, Person and Pet classes where a person has a pet, and a pet has an owner.
//*     Class and Struct:
//* A class and a struct with references to each other.
//* For example, Person (class) and Address (struct) where a person has an address, and the address has a reference to the person.

//*     Closures:
//* Demonstrating how closures can capture references and create retain cycles.
//* Use [weak self] to capture self weakly in closures and [unowned self] for unowned references.
//*     Delegation:
//* Show how delegation can create retain cycles if not handled properly.

//* Create a protocol, a delegate class, and a delegate owner class.
//* Implement the delegate pattern and use [weak self] in delegate properties.

//*     Timers and Dispatch Queues:
//* Use timers and dispatch queues that can capture self.
//* Explain how to avoid retain cycles by using [weak self] in timer closures.

//*     Parent-Child View Controller Relationship:
//* Demonstrating how view controllers can create retain cycles in parent-child relationships.
//* Show how to use [weak self] or [unowned self] in closures when referencing view controllers.


//*     Singleton Pattern:
//* Explain how singletons can create strong references and retain objects indefinitely.
//* Show how to use [weak self] or [unowned self] when referencing singletons.


//*     Weak vs. Unowned References:
//* Highlight the differences between weak and unowned references and when to use each.
//* Create examples where one is more appropriate than the other.

//*     Protocol Extensions:
//* Explain how using protocol extensions can sometimes create retain cycles.
//* Show how to avoid them by using [weak self] in protocol extension methods.


//*     Parent-Child Object Relationship:
//* Demonstrate how a parent object can hold a strong reference to its child, creating a retain cycle.
//* Use [weak self] or [unowned self] to break the cycle.


//*     ARC (Automatic Reference Counting):
//* Discuss the basics of ARC and how it helps manage memory in Swift.
//* Explain that retain cycles can lead to memory leaks if not resolved.


//*     Debugging Retain Cycles:
//* Use Xcode's Instruments tool to detect and debug retain cycles.
//* Show how to identify memory leaks in your code.
//*     Best Practices:
//* Summarize best practices for avoiding retain cycles in Swift.
//* Emphasize using [weak self] or [unowned self] as appropriate and understanding the ownership semantics.


class LandingVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
      // MARK: - ... (otherRequiredTest)
    otherRequiredTest()
  }
  
  func otherRequiredTest(){
    
      // MARK: - 1. Two classes
          let classTester = TestTwoClasses()
          classTester.testAllCases()
    
      //      // MARK: - 2. class and Struct
      //    let structTester = ClassAndStruct()
      //    structTester.testAllCases()
    
      // MARK: - 3. Closures
      //    let numberOfInstances = 10
      //    var instances: [ClosureTester] = []
      //
      //    for _ in 0..<numberOfInstances {
      //      let instance = ClosureTester()
      //      instance.testAllCases()
      //      instances.append(instance)
      //
      //    }
      //
      //      // Release the instances to see the deinit messages
      //    instances.removeAll()
    
      // MARK: - 4. Delegation
      //    let delegationTester = TestDelegation()
      //    delegationTester.testAllCases()
      //
      //      // MARK: - 5. TestTimers
//    let timerTester = TestTimers()
//    timerTester.testAllCases()
      //
      //      // MARK: - 6. Testing the cases
      //    let tester = ParentChildViewControllerTester()
      //    tester.testAllCases()
      //
      //      // MARK: - 6. Testing the singleton pattern
      //    let objectWithSingleton = ObjectWithSingletonReference()
      //      // Perform a task using the object
      //    objectWithSingleton.performTask()
      //      // Reset the singleton (set it to nil)
      //    SingletonManager.reset()
      //      // Attempting to perform a task using the object after resetting the singleton
      //    objectWithSingleton.performTask()
  }
  
    // Test Weak Reference
  func testWeakReference() {
    if let strongHome = storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeVC{
      strongHome.addTimer()
      self.navigationController?.pushViewController(strongHome, animated: true)
    }
  }
  
    // Test Strong Reference
//  func testStrongReference() {
//      // Create a strong reference to HomeVC
//    var strongHomeVC: HomeVC?
//    weakHomeVC = storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeVC
//      // Push HomeVC onto the navigation stack
//    self.navigationController?.pushViewController(strongHomeVC!, animated: true)
//    
//      // Test strong reference (should print "Hello" after 15 seconds)
//    strongHomeVC?.addTimer()
//    
//      // Pop HomeVC from the navigation stack
////    self.navigationController?.popViewController(animated: true)
//    
//      // Check if HomeVC is deallocated after popping
//    if let homeVC = strongHomeVC {
//      print("strongHomeVC is deallocated after popping: \(homeVC.isDeallocated)")
//    }
//    
//      // Attempt to access HomeVC using a weak reference (should be nil)
//    print("strongHomeVC is nil after popping: \(strongHomeVC == nil)")
//  }
//  
    // Test Unknown Reference
//  func testUnknownReference() {
//      // Create a strong reference to HomeVC
//    var strongHomeVC: HomeVC? = HomeVC()
//    
//      // Push HomeVC onto the navigation stack
//    self.navigationController?.pushViewController(strongHomeVC!, animated: true)
//    
//      // Pop HomeVC from the navigation stack
////    self.navigationController?.popViewController(animated: true)
//    
//      // Check if HomeVC is deallocated after popping
//    if let homeVC = strongHomeVC {
//      print("strongHomeVC is deallocated after popping: \(homeVC.isDeallocated)")
//    }
//  }
  
  @IBAction func goToHome(_ sender: UIButton) {
      // Call the test methods as needed
      // Example:
       testWeakReference()
//       testStrongReference()
//       testUnknownReference()
  }
}
