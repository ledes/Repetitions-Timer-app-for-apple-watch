//
//  thirtyController.swift
//  repetitions timer
//
//  Created by Pablo on 2/22/16.
//  Copyright © 2016 Pablo. All rights reserved.
//

import Foundation
import WatchKit


class ThirtyController: WKInterfaceController {
    
    @IBOutlet var second_image: WKInterfaceImage!
    @IBOutlet var result_label: WKInterfaceLabel!
    @IBOutlet var startButton: WKInterfaceButton!
    @IBOutlet var restLabel: WKInterfaceLabel!
    
    
    var count = 31
    var restCount = 31
    var repetitionNumber = 0
    var timer = NSTimer()
    var started = false
    
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
//            self.startButton.setBackgroundColor("#ffff")
            started = true


        } else if started == true {
            self.timer.invalidate()
            self.startButton.setTitle("Resume")
            started = false
        }

    }
    
    
    func result() {
        if repetitionNumber == 155 {
            self.restLabel.setText("Nice work!")
            self.startButton.setHidden(true)
            self.timer.invalidate()


        }else {
        
            if  count == 0 {

                if restCount != 0{
                    if restCount <= 3 {
                        restCount -= 1
                        repetitionNumber += 1
                        self.restLabel.setText("Rest")
                        self.second_image.setImageNamed("second\(restCount).png")
                        WKInterfaceDevice.currentDevice().playHaptic(.Notification)
                        print("vibration1")
                    
                    } else if restCount == 31{
                        WKInterfaceDevice.currentDevice().playHaptic(.Notification)
                        print("vibration2")
                        restCount -= 1
                        repetitionNumber += 1
                        self.second_image.setImageNamed("second\(restCount).png")

                        
                    }else{
                        restCount -= 1
                        repetitionNumber += 1
                        self.restLabel.setText("Rest")
                        self.second_image.setImageNamed("second\(restCount).png")
                    }

                    
                }else {
                    count = 31
                    restCount = 31
                }
                
            }else {
                self.restLabel.setText("Work!")
                count -= 1
                repetitionNumber += 1
                self.second_image.setImageNamed("second\(count).png")
//                self.result_label.setText("\(count)")
            }
        }
    }

    
}