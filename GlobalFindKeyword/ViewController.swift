//
//  ViewController.swift
//  GlobalFindKeyword
//
//  Created by usagimaru on 2024/12/23.
//

import Cocoa

class ViewController: NSViewController {
	@IBOutlet var searchField: NSSearchField!
	@IBOutlet var searchOption: NSButton!
	
	var findString: String = "" { didSet {
		// Update UI
		searchField.stringValue = findString
		
		// Apply new find string to the find buffer.
		if searchOption.state == .on {
			let findPBoard = NSPasteboard(name: .find)
			findPBoard.clearContents()
			findPBoard.setString(findString, forType: .string)
			
			print("reset find buffer: '\(oldValue)' -> '\(findString)'")
		}
	}}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Observe app activation
		NotificationCenter.default.addObserver(forName: NSApplication.didBecomeActiveNotification, object: NSApp, queue: nil) { notif in
			print("app is active")
			
			// Get the find buffer with `NSPasteboardNameFind` (ObjC) or `NSPasteboard.Name.find` (Swift)
			// Older name was `NSFindPboard`.
			// https://developer.apple.com/documentation/appkit/nspasteboard/name-swift.struct/find
			let findPBoard = NSPasteboard(name: .find)
			
			// Update findString with the find buffer if needed.
			if let string = findPBoard.string(forType: .string), self.searchOption.state == .on {
				self.findString = string
			}
		}
	}
	
	@IBAction func searchAction(_ sender: Any) {
		findString = searchField.stringValue
	}

}

