//
//  AppDelegate.swift
//  topmenu
//
//  Created by Justas Trimailovas on 10/10/15.
//  Copyright © 2015 Justas Trimailovas. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!
  let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)

  func applicationDidFinishLaunching(aNotification: NSNotification) {
    // Insert code here to initialize your application
    let button = statusItem.button
    button!.title = "text"
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }


}