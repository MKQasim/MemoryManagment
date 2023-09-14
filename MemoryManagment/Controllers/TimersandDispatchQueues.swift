//
//  TimersandDispatchQueues.swift
//  MemoryManagment
//
//  Created by KamsQue on 08/09/2023.
//

import Foundation
  // MARK: - Protocol

protocol TimerDelegate: AnyObject {
  func timerDidFire()
}

  // MARK: - Class Example

class ClassTimer {
  weak var delegate: TimerDelegate?
  var timer: Timer?
  
  init() {
    timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
  }
  
  @objc private func timerFired() {
    delegate?.timerDidFire()
  }
  
  deinit {
    timer?.invalidate()
  }
}

class ClassTimerDelegate: TimerDelegate {
  func timerDidFire() {
    print("Class Timer Delegate: Timer fired!")
  }
}

  // MARK: - Struct Example

struct StructTimer {
  var timer: Timer?
  
  init() {
    timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
      print("Struct Timer: Timer fired!")
    }
  }
  
  func cancelTimer() {
    timer?.invalidate()
  }
}

  // MARK: - Closure Example

class ClosureTimer {
  var timer: Timer?
  var timerClosure: (() -> Void)?
  
  init() {
    timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] timer in
      self?.timerClosure?()
    }
  }
  
  deinit {
    timer?.invalidate()
  }
}

class TestTimers {
  func testAllCases() {
      // MARK: - Class Timer with Weak Reference
    let classTimerDelegate = ClassTimerDelegate()
    var classTimer: ClassTimer? = ClassTimer()
    classTimer?.delegate = classTimerDelegate
    print("Class Timer with Weak Reference: Timer started.")
    
      // MARK: - Struct Timer with Strong Reference
    var structTimer: StructTimer? = StructTimer()
    print("Struct Timer with Strong Reference: Timer started.")
    
      // MARK: - Closure Timer with Unowned Reference
    var closureTimer: ClosureTimer? = ClosureTimer()
    var timerClosure: (() -> Void)? = nil
    
    timerClosure = { [unowned closureTimer] in
      var capturedTimer = closureTimer // Create a mutable reference
      capturedTimer?.timerClosure?()
      capturedTimer = nil // Release the reference
    }
    
    closureTimer?.timerClosure = timerClosure
    print("Closure Timer with Unowned Reference: Timer started.")


    
      // MARK: - Dispatch Queue with Closure
    DispatchQueue.global().async {
      print("Dispatch Queue with Strong Self Closure: Task started on a global queue.")
      DispatchQueue.main.async {
        print("Dispatch Queue with Strong Self Closure: Task executed on the main queue.")
      }
    }
    
      // MARK: - Dispatch Queue with Weak Self
    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      print("Dispatch Queue with Weak Self: Task started on a global queue.")
      DispatchQueue.main.async {
        print("Dispatch Queue with Weak Self: Task executed on the main queue.")
        self.someMethod()
      }
    }
  }
  
  func someMethod() {
    print("Dispatch Queue with Weak Self: Method called on main queue.")
  }
}


