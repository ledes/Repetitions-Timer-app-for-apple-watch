//
//  sixtyController.swift
//  repetitions timer
//
//  Created by Pablo on 2/22/16.
//  Copyright © 2016 Pablo. All rights reserved.
//


import Foundation
import WatchKit


class SixtyController: WKInterfaceController {
    
    
    @IBOutlet var readyLabel: WKInterfaceLabel!
    
    
    @IBOutlet var imageLabel: WKInterfaceImage!
    
    @IBOutlet var startButton: WKInterfaceButton!
    
    
    var count = 61
    var restCount = 31
    var repetitionNumber = 0
    var timer = NSTimer()
    var started = false
    //
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.setTitle("Back")
        
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        timer.invalidate()
    }
    
    
    @IBAction func start_button() {
    
        if started == false {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("result"), userInfo: nil, repeats: true)
            self.startButton.setTitle("Stop")
            started = true
            
            
        } else if started == true {
            self.timer.invalidate()
            self.startButton.setTitle("Resume")
            started = false
        }
        
    }
    
    
    func result() {
        if repetitionNumber == 245 {
            self.readyLabel.setText("Nice work!")
            self.startButton.setHidden(true)
            self.timer.invalidate()
            
            
        }else {
            
            if  count == 0 {
                
                if restCount != 0{
                    if restCount <= 3 {
                        restCount -= 1
                        repetitionNumber += 1
                        self.readyLabel.setText("Rest")
                        self.imageLabel.setImageNamed("forty\(restCount).png")
                        WKInterfaceDevice.currentDevice().playHaptic(.Notification)
                        print("vibration1")
                        
                    } else if restCount == 31{
                        WKInterfaceDevice.currentDevice().playHaptic(.Notification)
                        print("vibration2")
                        restCount -= 1
                        repetitionNumber += 1
                        self.imageLabel.setImageNamed("second\(restCount).png")
                        
                        
                    }else{
                        restCount -= 1
                        repetitionNumber += 1
                        self.readyLabel.setText("Rest")
                        self.imageLabel.setImageNamed("second\(restCount).png")
                    }
                    
                    
                }else {
                    count = 61
                    restCount = 31
                }
                
            }else {
                self.readyLabel.setText("Work!")
                count -= 1
                repetitionNumber += 1
                self.imageLabel.setImageNamed("sixty\(count).png")
                
            }
        }
    }
    
    
    
}