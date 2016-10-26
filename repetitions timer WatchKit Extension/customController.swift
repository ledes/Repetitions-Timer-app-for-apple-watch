//
//  customController.swift
//  repetitions timer
//
//  Created by Pablo on 2/22/16.
//  Copyright © 2016 Pablo. All rights reserved.
//

import Foundation
import WatchKit


class CustomController: WKInterfaceController {
    
    @IBOutlet var repetitionsPicker: WKInterfacePicker!
    
    @IBOutlet var durationPicker: WKInterfacePicker!
    
    @IBOutlet var breaksPicker: WKInterfacePicker!
    
    var pickerRepetition = 0
    var pickerDuration = 0
    var pickerBreaks = 0
    
    
    var repetitions: [(Int)] = [
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    ]
    
    var duration: [(Int)] = [
        10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 120
    ]
    
    var breaks: [(Int)] = [
        10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 120
    ]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.setTitle("Back")
        
        
        let pickerItems: [WKPickerItem] = repetitions.map {
            let pickerItem = WKPickerItem()
            pickerItem.caption = "\($0) rep."
            pickerItem.title = "\($0)"
            return pickerItem
        }
         repetitionsPicker.setItems(pickerItems)
        
        let pickerItems2: [WKPickerItem] = duration.map {
            let pickerItem = WKPickerItem()
            pickerItem.caption = "of \($0)sec."
            pickerItem.title = "\($0)"
            return pickerItem
        }
        durationPicker.setItems(pickerItems2)
        
        let pickerItems3: [WKPickerItem] = breaks.map {
            let pickerItem = WKPickerItem()
            pickerItem.caption = "of \($0)sec."
            pickerItem.title = "\($0)"
            return pickerItem
        }
        breaksPicker.setItems(pickerItems3)

 
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        repetitionsPicker?.setSelectedItemIndex(2)
        durationPicker?.setSelectedItemIndex(2)
        breaksPicker?.setSelectedItemIndex(2)


    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    @IBAction func pickedRepetition(value: Int) {
        pickerRepetition = repetitions[value]
    }
    
    
    @IBAction func pickedDurations(value: Int) {
        pickerDuration = duration[value]

    }
    
    @IBAction func pickedBreaks(value: Int) {
        pickerBreaks = breaks[value]

    }
    
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) ->
        AnyObject? {
  
            return [ pickerRepetition, pickerDuration, pickerBreaks ]
    }
    
//    
//    @IBAction func repetitions_picker(value: Int) {
//        repetitionsPicker.setSelectedItemIndex(repetitions[value])
//    }
//    

}