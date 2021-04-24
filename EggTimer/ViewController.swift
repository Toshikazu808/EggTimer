//
//  ViewController.swift
//  EggTimer
//
//  Created by Ryan Kanno on 5/10/20.
//  Copyright © 2020 Ryan Kanno. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes:[Int] = [600, 360] // Index 0 is for hard, index 1 is for medium
    
    var secondsPassed:Int = 0
    var totalTimeInSeconds:Int = 0
    
    var timer = Timer()
    
    var tag:Int?
    
    var minutesLeft:Int = 0
    var secondsInOneMinute:Int = 60
    
    var audioPlayer:AVAudioPlayer?
    let jeopardySong = "JeopardyMusic"

    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0
        
    } // End of func viewDidLoad()
    
    
    func playSong(filename:String) {
        let url = Bundle.main.url(forResource: filename, withExtension: "mp3")
        
        guard url != nil else {
            return
        }
        // Create the audio player and play the sound
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer?.play()
        } catch {
            print("error playing audio")
        }
    } // End of func playSong
    
    
    @IBAction func eggSelectionTapped(_ sender: UIButton) {
        // Get the tag
        tag = ((sender as UIButton).tag)
        timer.invalidate()
        secondsPassed = 0
        totalTimeInSeconds = 0
        progressBar.progress = 0.0
   
        totalTimeInSeconds = eggTimes[tag!]
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        playSong(filename: "JeopardyMusic")
        
    } // End of @IBAction func eggSelectionTapped
    
    // This function fires with each timeInterval (1.0 seconds) with the Timer.scheduledTimer #selector(@objc func)
    @objc func updateTimer() {
        if secondsPassed < totalTimeInSeconds {
            secondsPassed += 1
            let percentageProgress:Float = Float(secondsPassed) / Float(totalTimeInSeconds)
            progressBar.progress = percentageProgress
            
            minutesLeft = (totalTimeInSeconds - secondsPassed) / 60
            
            if secondsInOneMinute <= 60{
                secondsInOneMinute -= 1

                if secondsInOneMinute < 10 && secondsInOneMinute > 0 {
                    timeLeftLabel.text = "\(minutesLeft):0\(secondsInOneMinute)"
                } else if secondsInOneMinute == 0 {
                    timeLeftLabel.text = "\(minutesLeft):00"
                    secondsInOneMinute = 60 // Resets the minute count down
                } else {
                    timeLeftLabel.text = "\(minutesLeft):\(secondsInOneMinute)"
                }
            }
            
        } else {
            timer.invalidate()
            timeLeftLabel.text = "DONE!"
            audioPlayer?.stop()
        }
    } // End of @objc func updateTimer
    
    @IBAction func resetTapped(_ sender: UIButton) {
        tag = nil
        timer.invalidate()
        secondsPassed = 0
        totalTimeInSeconds = 0
        minutesLeft = 0
        secondsInOneMinute = 0
        progressBar.progress = 0.0
        timeLeftLabel.text = "00:00"
        audioPlayer?.stop()
    } // end of @IBAction fun resetTapped

} // End of class ViewController

