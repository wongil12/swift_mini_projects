//
//  StopWatchViewController.swift
//  Clock
//
//  Created by Wongil on 2022/03/23.
//

import UIKit

enum WatchStatus {
    case start
    case stop
}

struct TimeSet {
    var hour: String
    var minute: String
    var second: String
    var milliSecond: String
}

class StopWatchViewController: UIViewController {
    let timerSelector: Selector = #selector(StopWatchViewController.updateTimer)
    
    @IBOutlet var btnLeft: UIButton!
    @IBOutlet var btnControl: UIButton!
    
    @IBOutlet var lblMinute: UILabel!
    @IBOutlet var lblSecond: UILabel!
    @IBOutlet var lblMiiliSecond: UILabel!
    
    
    var watchStatus: WatchStatus = .stop
    var timer: Timer!
    var startTime = Date()
    var accuTime: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnControl.layer.cornerRadius = 40
        btnLeft.layer.cornerRadius = 40
        
        changeControlBtn(.start)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tchBtnControl(_ sender: UIButton) {
        changeControlBtn(self.watchStatus)
        switch self.watchStatus {
        case .stop:
            self.watchStatus = .start
            self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: timerSelector, userInfo: nil, repeats: true)
            btnControl.setTitle("중단", for: .normal)
            break
        case .start:
            self.watchStatus = .stop
            self.timer?.invalidate()
            self.timer = nil
            btnControl.setTitle("시작", for: .normal)
            break
        }
    }
    
    @objc func updateTimer() {
        self.accuTime += 0.01
        
        let timeSet = formatTime(self.accuTime)
        
        lblMinute.text = timeSet.minute
        lblSecond.text = timeSet.second
        lblMiiliSecond.text = timeSet.milliSecond
    }
    
    func formatTime(_ time:Double) -> TimeSet {
        let hour = (Int)(fmod(time / 60 / 60, 12)) //시간 구하기
        let minute = (Int)(fmod(time / 60, 60)) // 분 구하기
        let second = (Int)(fmod(time, 60))
        let milliSecond = (Int)((time - floor(time)) * 100)
        
        let timeSet: TimeSet = TimeSet(hour: String(format: "%02d", hour), minute: String(format: "%02d", minute), second: String(format: "%02d", second), milliSecond: String(format: "%02d", milliSecond))
        
        return timeSet
    }
    
    func changeControlBtn (_ status: WatchStatus) {
        switch status {
        case .stop:
            btnControl.setTitle("중단", for: .normal)
            btnControl.backgroundColor = UIColor(red: 50/255, green: 14/255, blue: 11/255, alpha: 1)
            btnControl.setTitleColor(UIColor(red: 255/255, green: 69/255, blue: 58/255, alpha: 1), for: .normal)
            break
        case .start:
            btnControl.setTitle("시작", for: .normal)
            btnControl.backgroundColor = UIColor(red: 8/255, green: 42/255, blue: 17/255, alpha: 1)
            btnControl.setTitleColor(UIColor(red: 46/255, green: 209/255, blue: 88/255, alpha: 1), for: .normal)
            break
        }
    }

}
