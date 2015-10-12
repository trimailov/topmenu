//
//  MenuView.swift
//  topmenu
//
//  Created by Justas Trimailovas on 12/10/15.
//  Copyright © 2015 Justas Trimailovas. All rights reserved.
//

import Cocoa
import Foundation
import SystemKit

class MenuView: NSObject {
  let button: NSStatusBarButton
  var sys = System()

  init(statusItem: NSStatusItem) {
    self.button = statusItem.button!

    let menu = NSMenu()
    menu.addItem(NSMenuItem(title: "Quit Quotes", action: Selector("terminate:"), keyEquivalent: "q"))
    statusItem.menu = menu
  }

  func run() {
    let _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "checkCpu", userInfo: nil, repeats: true)
  }

  func checkCpu() {
    let cpuUsage = sys.usageCPU()
    print(cpuUsage)

    let comboUsage = cpuUsage.system + cpuUsage.user
    self.button.title = String(format: "%.2f %%", comboUsage)
  }

}
