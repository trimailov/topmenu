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
  var history_queue = StatsHistoryQueue<Double>()

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
//    self.button.title = String(format: "%.2f %%", comboUsage)
    history_queue.enqueue(comboUsage)
    self.drawMenuImage()
  }

  func drawMenuImage() {
    let path: NSBezierPath = NSBezierPath()

    path.moveToPoint(NSPoint(x: history_queue.length - history_queue.items.count + 1, y: 0))

    for (index, value) in history_queue.items.enumerate() {
      let x_coordinate = history_queue.length - history_queue.items.count + 1 + index
      let normalized_value: Int = Int(value / 5)
      print(x_coordinate, normalized_value)
      path.lineToPoint(NSPoint(x: x_coordinate, y: normalized_value))
    }
    path.lineToPoint(NSPoint(x: 20, y: 0))
    path.closePath()

    let img: NSImage = NSImage(size: NSSize(width: 20, height: 20))
    // set as template, so switching to/from dark mode would work
    img.template = true
    img.lockFocus()
    path.fill()
    img.unlockFocus()

    self.button.image = img
  }
}
