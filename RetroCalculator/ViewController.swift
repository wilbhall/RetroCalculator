//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Joseph Leichter on 12/9/16.
//  Copyright © 2016 Joseph Leichter. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    enum Operation : String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        outputLbl.text = "0"
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        
        
        do {
           try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        

    }


    @IBAction func numberPressed(sender: UIButton){
        
        playSound()
        self.runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    
    @IBAction func onDividePressed(_ sender: Any) {
            processOperation(operation: .Divide)
    }
    
    
    @IBAction func onMultiplyPressed(_ sender: Any) {
                processOperation(operation: .Multiply)
    }
    
    
    
    @IBAction func onSubtractPressed(_ sender: Any) {
            processOperation(operation: .Subtract)
    }
    
    
    @IBAction func onAddPressed(_ sender: Any) {
        
            processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(_ sender: Any) {
      processOperation(operation: currentOperation)
    }
    

    
    
    @IBAction func clearPressed(_ sender: Any) {
          playSound()
        
         currentOperation = Operation.Empty
         runningNumber = ""
          leftValStr = ""
          rightValStr = ""
          result = ""
          outputLbl.text = "0"
    }
    
    
    
    
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operation){
        
        playSound()
        if currentOperation != Operation.Empty{
            
            //A user selected an operator,
            //but then selected another operator
            //without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide{
                       result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if currentOperation == Operation.Add{
                                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                
              leftValStr = result
              outputLbl.text = result
                
            }
            
            currentOperation = operation
        }else{
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

