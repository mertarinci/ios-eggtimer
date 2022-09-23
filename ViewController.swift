//
//  ViewController.swift
//  EggTimer



import UIKit
import AVFoundation
var player: AVAudioPlayer?

class ViewController: UIViewController {

    @IBOutlet weak var titleTop: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    let eggTimes = [
        "Soft" : 300,
        "Medium" : 420,
        "Hard" : 720]
    
    var timer = Timer()
    
    var totalTime = 0
    var secondsPassed = 0
    
    
    @IBAction func keyPressed(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.titleLabel?.text

        totalTime = eggTimes[hardness!]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleTop.text = "\(hardness!)"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
 @objc func updateCounter() {
        //example functionality
        if secondsPassed < totalTime {
        secondsPassed += 1
            
        let percentageProgress = (Float(secondsPassed) / Float(totalTime))
            
            progressBar.progress = percentageProgress
            
        }else{
            timer.invalidate()
            titleTop.text = "DONE"
            playSound()
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

