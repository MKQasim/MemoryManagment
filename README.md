# Memory Managment by Classes and with the Use of ViewController Both 
iOS Interview questions || Weak vs Unowned vs Strong || Retain Cycle || Memory management in iOS


class LandingVC: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
// By class
    let car = Car(name: "4234", veichle: nil)
    let veichle = Veichle(id: "10000", car: nil)
    veichle.car = car
    car.veichle = veichle
  }
  @IBAction func goToHome(_ sender: UIButton) {
    let vc = storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

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

class Car {
  var veichle : Veichle?
  let name : String
  init(name: String, veichle: Veichle?) {
    self.name = name
    self.veichle = veichle
    print("\(self) allocated")
  }
  
  deinit {
    print("\(self) De allocated")
  }
}

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
