# iOS Interview Questions

## Concepts Covered
- Weak vs. Unowned vs. Strong References
- Retain Cycle
- Memory Management in iOS

## `LandingVC` Class

```swift
class LandingVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating instances of Car and Vehicle classes
        let car = Car(name: "4234", vehicle: nil)
        let vehicle = Vehicle(id: "10000", car: nil)
        
        // Establishing references between car and vehicle
        vehicle.car = car
        car.vehicle = vehicle
    }

    @IBAction func goToHome(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



class HomeVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("(self) is allocated")
        addTimer()
    }

    func printHello() {
        print("Hello")
    }

    func addTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) { [weak self] in
            // [unowned self] in can also be used
            // print("(self)")
            self?.printHello()
        }
    }

    deinit {
        print("(self) deinit de Allocated")
    }

    @IBAction func goBackToLandingPage(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

class Car {
    var vehicle: Vehicle?
    let name: String
    
    init(name: String, vehicle: Vehicle?) {
        self.name = name
        self.vehicle = vehicle
        print("(self) allocated")
    }

    deinit {
        print("(self) Deallocated")
    }
}



class Vehicle {
    let id: String
    weak var car: Car?
    
    init(id: String, car: Car?) {
        self.id = id
        self.car = car
        print("(self) allocated")
    }

    deinit {
        print("(self) Deallocated")
    }
}
