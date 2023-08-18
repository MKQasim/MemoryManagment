//
//  ViewController.swift
//  MemoryManagment
//
//  Created by KamsQue on 18/08/2023.
//

import UIKit

class LandingVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let car = Car(name: "4234", veichle: nil)
    let veichle = Veichle(id: "10000", car: nil)
    veichle.car = car
    car.veichle = veichle
    
//    Veichle(id: "10000", car: nil)
  }


  
  
  @IBAction func goToHome(_ sender: UIButton) {
    
    let vc = storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
    self.navigationController?.pushViewController(vc, animated: true)
    
  }
  
  
}

