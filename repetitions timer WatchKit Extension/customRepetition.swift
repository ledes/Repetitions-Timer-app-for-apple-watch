//
//  customRepetition.swift
//  repetitions timer
//
//  Created by Pablo on 2/23/16.
//  Copyright © 2016 Pablo. All rights reserved.
//

import Foundation
import WatchKit



class CustomRepetitionController: WKInterfaceController {
    
//    @IBOutlet var totalDurationLabel: WKInterfaceLabel!
    @IBOutlet var pogressLabel: WKInterfaceLabel!
    @IBOutlet var startButton: WKInterfaceButton!
    @IBOutlet var readyLabel: WKInterfaceLabel!
    
    @IBOutlet var progressionBar: WKInterfaceGroup!
    
    var numberOfRepetitions: Int?
    var repetitionDuration: Int?
    var resetDuration: Int?
    var breakDuration: Int?
    var resetBreak: Int?
    

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.setTitle("Back")
        if let data = context as? [Int] {
            numberOfRepetitions = data[0]
            repetitionDuration = data[1] + 1
            resetDuration = data [1] + 1
            breakDuration = data[2] + 1
            resetBreak = data[2] + 1
        }
    }
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
//        totalDurationLabel.setText("\(repetitionDuration!)")
        pogressLabel.setText("\(repetitionDuration! - 1)")
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        timer.invalidate()
    }

    
    
    var repetitionNumber = 0
    var timer = NSTimer()
    var started = false
   
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

        let endingTime = ( (resetDuration! * numberOfRepetitions!) + (resetBreak! * (numberOfRepetitions! - 1 ) ))
        
        if repetitionNumber == endingTime {
            WKInterfaceDevice.currentDevice().playHaptic(.Notification)
            print("final vibration")
            self.readyLabel.setText("Nice work!")
            self.startButton.setHidden(true)
            self.timer.invalidate()
            
            
        }else {
            let restProgress = ( Float(breakDuration!) / Float(resetBreak!) ) * 100
            
            if  repetitionDuration! == 0 {
                self.readyLabel.setText("Rest")
                
                
                if breakDuration! != 0{
                    if breakDuration! <= 3 {
                        breakDuration! -= 1
                        repetitionNumber += 1
                        let restProgressBar = String(format:"%.0f", restProgress)
                        print(restProgressBar)
                        print(breakDuration!)
                        self.progressionBar.setBackgroundImageNamed("custom\(restProgressBar).png")

                        self.pogressLabel.setText("\(breakDuration!)")
                        WKInterfaceDevice.currentDevice().playHaptic(.Notification)
                        print("vibration1")
                        
                    } else if breakDuration! == resetBreak!{
                        WKInterfaceDevice.currentDevice().playHaptic(.Notification)
                        print("vibration2. Finish work start of rest")
                        print(restProgress)
                        print(breakDuration!)
                        breakDuration! -= 1
                        repetitionNumber += 1
                        self.pogressLabel.setText("\(breakDuration!)")
                        let restProgressBar = String(format:"%.0f", restProgress)
                        self.progressionBar.setBackgroundImageNamed("custom\(restProgressBar).png")
                        
                        
                    }else{
                        self.readyLabel.setText("Rest")
                        print(restProgress)
                        print(breakDuration!)
                        breakDuration! -= 1
                        repetitionNumber += 1
                        self.pogressLabel.setText("\(breakDuration!)")
                        let restProgressBar = String(format:"%.0f", restProgress)
                        self.progressionBar.setBackgroundImageNamed("custom\(restProgressBar).png")
                    }
                    
                    
                }else {
                    repetitionDuration! = resetDuration!
                    breakDuration! = resetBreak!
                }
                
            }else {
                self.readyLabel.setText("Work!")
                print(repetitionDuration!)
                repetitionDuration! -= 1
                repetitionNumber += 1
                let workProgress = (Float(repetitionDuration!) / Float(resetDuration!)) * 100
                let workProgressRound = String(format:"%.0f", workProgress)
                self.pogressLabel.setText("\(repetitionDuration!)")
                self.progressionBar.setBackgroundImageNamed("custom\(workProgressRound).png")
           
                
            }
        }
    }

    
}