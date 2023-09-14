  //
  //  HomeViewController.swift
  //  MemoryManagment
  //
  //  Created by KamsQue on 18/08/2023.
  //

import UIKit

//class HomeVC: UIViewController {
//  
//  override func viewDidLoad() {
//    print("\(self) is allocated ")
//    super.viewDidLoad()
////    MARK: - class and closure
//
////    addTimer()
//  }
//  
////  func printHello(){
////    print("HEllo")
////  }
////  
////  func addTimer(){
////    DispatchQueue.main.asyncAfter(deadline: .now() + 15) { [weak self] in  //[unowned self] in ,
////      print("\(self)")
////      self?.printHello()
////    }
////  }
//  
//  deinit {
//    print("\(self) deinit de Allocated")
//  }
//  
//  @IBAction func goBackToLandingPage(_ sender: UIButton) {
//    self.navigationController?.popViewController(animated: true)
//  }
//}


class HomeVC: UIViewController {
  
  var isDeallocated = false
  
  override func viewDidLoad() {
    print("view did load \(self) is allocated")
    super.viewDidLoad()
    
      // MARK: - 3. Timer and Closure
    
    addTimer()
  }
  
  func printHello() {
    print("Hello")
  }
  
  func addTimer() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 15) { [weak self] in
        // Use [weak self] to avoid a strong reference cycle
      print("\(self)")
      print("inside addTimer \(self) call")
      self?.printHello()
    }
  }
  
  deinit {
    isDeallocated = true
    print("\(self) deallocated")
  }
  
  @IBAction func goBackToLandingPage(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}

