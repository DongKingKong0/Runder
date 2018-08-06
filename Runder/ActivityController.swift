//
//  ActivityController.swift
//  Runder
//
//  Created by Lorenzo on 06.08.18.
//  Copyright © 2018 New Image. All rights reserved.
//

import UIKit
import Foundation

class ActivityController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        print("start")
        
        startButton.isHidden = true
        pauseButton.isHidden = false
        stopButton.isHidden = false
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        print("stop")
        
        startButton.isHidden = false
        stopButton.isEnabled = false
        pauseButton.isHidden = true
        resumeButton.isHidden = true
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        print("pause")
        
        pauseButton.isHidden = true
        resumeButton.isHidden = false
    }
    
    @IBAction func resumeButtonPressed(_ sender: Any) {
        print("resume")
        
        resumeButton.isHidden = true
        pauseButton.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Round buttons
        setButtonStyle(button: startButton)
        setButtonStyle(button: stopButton)
        setButtonStyle(button: pauseButton)
        setButtonStyle(button: resumeButton)
        
        stopButton.isHidden = true
        pauseButton.isHidden = true
        resumeButton.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setButtonStyle(button: UIButton) {
        button.layer.cornerRadius = 32
        button.clipsToBounds = true
    }
    
}

