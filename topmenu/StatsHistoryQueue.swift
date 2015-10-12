//
//  StatsHistoryQueue.swift
//  topmenu
//
//  Created by Justas Trimailovas on 12/10/15.
//  Copyright © 2015 Justas Trimailovas. All rights reserved.
//

import Cocoa
import Foundation

class StatsHistoryQueue<Element> {
  var items = [Element]()
  var length: Int

  init(length: Int = 20) {
    self.length = length
  }

  func enqueue(item: Element) {
    items.append(item)

    if items.count > self.length {
      self.dequeue()
    }
  }

  func dequeue() {
    items.removeAtIndex(0)
  }
}
