//
//  AppDelegate.swift
//  MenuBarCountdown
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem = NSStatusBar.system().statusItem(withLength: -1)
    @IBOutlet var mainMenu: NSMenu!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.menu = mainMenu
        updateDisplay()
        let aSelector : Selector = #selector(AppDelegate.updateDisplay)
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: aSelector, userInfo: nil, repeats: true)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func updateDisplay() {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"

        let endDate = dateStringFormatter.date(from: "2016-11-05")!
        let remainingTime = endDate.timeIntervalSince(Date())
        let days =  Int(remainingTime / 60 / 60 / 24)
//        let hours = Int(remainingTime / 60 / 60 % 24)
//        let minutes = Int(remainingTime / 60 % 60)
//        let seconds = Int(remainingTime % 60)
//        statusItem.title = "あと\(days)日\(hours)時\(minutes)分\(seconds)秒"
        statusItem.title = "あと\(days)日"
    }

}

