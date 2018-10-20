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
        
        let url : String = "https://api.github.com/users/larryjung/repos"
        dataTask(url: url)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func updateDisplay() {
//        let dateStringFormatter = DateFormatter()
//        dateStringFormatter.dateFormat = "yyyy-MM-dd"
//
//        let endDate = dateStringFormatter.date(from: "2018-10-20")!
//        let remainingTime = Int(endDate.timeIntervalSince(Date()))
//        let days =  remainingTime / 60 / 60 / 24
//        statusItem.title = "あと\(days)日"
        statusItem.title = "Daily commit 'X' Combo!!"
    }
    
    func dataTask(url: String) {
        let url = URL(string: url)
        let task = URLSession.shared.dataTask(with: url!, completionHandler : {
            (data, response, error) -> Void in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                // fail case handling
                return
            }
            guard let returnStr = String(data: data!, encoding: .utf8) else {
                // success case handling
                return
                
            }
            let data = returnStr.data(using: .utf8)!
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]{
                    print(jsonArray)
                } else {
                    print("bad json")
                }
            } catch let error as NSError {
                print(error)
            }
        })
        // execute
        task.resume()
    }
}

