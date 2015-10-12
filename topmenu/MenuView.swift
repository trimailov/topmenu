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

  func drawMenuImage() {
    let path: NSBezierPath = NSBezierPath()
    path.moveToPoint(NSPoint(x: 0, y: 15))
    path.lineToPoint(NSPoint(x: 10, y: 15))
    path.lineToPoint(NSPoint(x: 10, y: 25))
    path.lineToPoint(NSPoint(x: 20, y: 25))
    path.lineToPoint(NSPoint(x: 20, y: 35))
    path.lineToPoint(NSPoint(x: 30, y: 35))
    path.lineToPoint(NSPoint(x: 30, y: 0))

    let fillColor = NSColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
    fillColor.set()
    path.fill()
    path.lineWidth = 5
    path.stroke()

    path.closePath()

    let img: NSImage = NSImage(size: NSSize(width: 50, height: 50))
    img.lockFocus()
    path.fill()
    img.unlockFocus()

    self.button.image = img
  }
}
