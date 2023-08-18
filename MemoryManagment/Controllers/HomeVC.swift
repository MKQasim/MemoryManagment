  //
  //  HomeViewController.swift
  //  MemoryManagment
  //
  //  Created by KamsQue on 18/08/2023.
  //

import UIKit

class HomeVC: UIViewController {
  
  override func viewDidLoad() {
    print("\(self) is allocated ")
    super.viewDidLoad()
    
    addTimer()
  }
  
  func printHello(){
    print("HEllo")
  }
  
  func addTimer(){
    DispatchQueue.main.asyncAfter(deadline: .now() + 15) { [weak self] in  //[unowned self] in ,
      print("\(self)")
      self?.printHello()
    }
  }
  
  deinit {
    print("\(self) deinit de Allocated")
  }
  
  @IBAction func goBackToLandingPage(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}


