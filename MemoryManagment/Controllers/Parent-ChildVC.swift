//
//  Parent-ChildVC.swift
//  MemoryManagment
//
//  Created by KamsQue on 08/09/2023.
//

import Foundation
import UIKit


  // Protocol for the delegate
protocol ChildViewControllerDelegate: AnyObject {
  func didFinishTask()
}

class ParentChildViewControllerTester {
  func testAllCases() {
      // Test different reference scenarios for parent-child view controller relationship
    testWeakReference()
    testStrongReference()
    testUnownedReference()
  }
  
  func testWeakReference() {
    var parentVC: ParentViewController? = ParentViewController()
      // Use nil for the `coder` parameter to create the child view controller
    var childVC: ChildViewController? = ChildViewController(coder: NSCoder())
    
      // Establish a weak reference from child to parent
    childVC?.parentVC = parentVC
    
      // Simulate deallocation of the parent view controller
    parentVC = nil
    
      // At this point, the parent view controller is deallocated,
      // and child view controller's weak reference becomes nil
    print("Child's weak reference to Parent: \(childVC?.parentVC != nil ? "Exists" : "Nil")")
  }
  
  func testStrongReference() {
    var parentVC: ParentViewController? = ParentViewController()
      // Use nil for the `coder` parameter to create the child view controller
    var childVC: ChildViewController? = ChildViewController(coder: NSCoder())
    
      // Establish a strong reference from child to parent
    childVC?.strongParentVC = parentVC
    
      // Simulate deallocation of the parent view controller
    parentVC = nil
    
      // At this point, the parent view controller is deallocated,
      // but child view controller's strong reference keeps it alive
    print("Child's strong reference to Parent: \(childVC?.strongParentVC != nil ? "Exists" : "Nil")")
  }
  
  func testUnownedReference() {
    var parentVC: ParentViewController? = ParentViewController()
    var childVC: ChildViewController? = ChildViewController(coder: NSCoder())
    
      // Establish an unowned reference from child to parent
    childVC?.unownedParentVC = parentVC!
    
      // Simulate deallocation of the parent view controller
    parentVC = nil
    
      // Attempting to access an unowned reference after deallocation is unsafe
      // Uncomment the next line to see the crash:
      // print("Child's unowned reference to Parent: \(childVC?.unownedParentVC != nil ? "Exists" : "Nil")")
  }
}

class ParentViewController: UIViewController, ChildViewControllerDelegate {
  var childViewController: ChildViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
      // Create and add the child view controller
    childViewController = ChildViewController(delegate: self, parentVC: self)
    addChild(childViewController!)
    view.addSubview(childViewController!.view)
    childViewController?.didMove(toParent: self)
  }
  
  func didFinishTask() {
    print("Task in child view controller finished.")
  }
}

class ChildViewController: UIViewController {
  weak var delegate: ChildViewControllerDelegate?
  weak var parentVC: ParentViewController?
  var strongParentVC: ParentViewController?
  unowned var unownedParentVC: ParentViewController
  
  init(delegate: ChildViewControllerDelegate, parentVC: ParentViewController) {
    self.delegate = delegate
    self.unownedParentVC = parentVC
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
      // Simulate a task completion in the child view controller
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
        // Use [weak self] to prevent a retain cycle
      self?.delegate?.didFinishTask()
    }
  }
}









