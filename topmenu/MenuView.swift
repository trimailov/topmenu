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
    menu.addItem(NSMenuItem(title: "About topmenu", action: Selector("orderFrontStandardAboutPanel:") , keyEquivalent: ""))
    menu.addItem(NSMenuItem.separatorItem())
    menu.addItem(NSMenuItem(title: "Quit topmenu", action: Selector("terminate:"), keyEquivalent: "q"))
    statusItem.menu = menu
  }
  

  func run() {
    let _ = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "checkCpu", userInfo: nil, repeats: true)
  }

  func checkCpu() {
    let cpuUsage = sys.usageCPU()

    let comboUsage = cpuUsage.system + cpuUsage.user
    history_queue.enqueue(comboUsage)
    self.drawMenuImage()
  }

  func drawMenuImage() {
    let path: NSBezierPath = NSBezierPath()

    path.moveToPoint(NSPoint(x: history_queue.length - history_queue.items.count + 1, y: 1))

    for (index, value) in history_queue.items.enumerate() {
      let x_coordinate = history_queue.length - history_queue.items.count + 1 + index
      // normalize value to the height of menu image height. 100 - are percent, 20 - menu image height in pixels
      let normalized_value: Int = Int(value / (100 / 18)) + 1
      path.lineToPoint(NSPoint(x: x_coordinate, y: normalized_value))
    }
    path.lineToPoint(NSPoint(x: 20, y: 0))
    path.closePath()
    
    let background: NSBezierPath = NSBezierPath(rect: NSRect(x: 0, y: 0, width: 20, height: 20))

    let img: NSImage = NSImage(size: NSSize(width: 20, height: 20))
    // set image as template, so switching to/from dark mode would work
    img.template = true
    img.lockFocus()
    path.fill()
    
    background.lineWidth = 2.0
    background.stroke()
    
    img.unlockFocus()

    self.button.image = img
  }
}
