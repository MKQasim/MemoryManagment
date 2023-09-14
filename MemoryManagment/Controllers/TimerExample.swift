//
//  TimerExample.swift
//  MemoryManagment
//
//  Created by KamsQue on 08/09/2023.
//

import Foundation
class TimerExample {
  
  var timer: Timer?
  
  init() {
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
      self?.timerCallback()
    }
  }
  
  func timerCallback() {
    print("Timer fired")
  }
  
  deinit {
    timer?.invalidate()
    print("TimerExample deallocated")
  }
}
