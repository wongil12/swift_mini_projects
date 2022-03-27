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

enum LeftStatus {
    case disable
    case lab
    case reset
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
    var leftStatus: LeftStatus = .disable
    var timer: Timer!
    var accuTime: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnControl.layer.cornerRadius = 40
        btnLeft.layer.cornerRadius = 40
        
        changeControlBtn(.start)
        changeLeftBtn(.disable)
        // Do any additional setup after loading the view.
    }
    
    // 시작 / 중지 버튼 클릭 이벤트
    @IBAction func tchBtnControl(_ sender: UIButton) {
        changeControlBtn(self.watchStatus)
        switch self.watchStatus {
        case .stop:
            self.watchStatus = .start
            self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: timerSelector, userInfo: nil, repeats: true)
            self.leftStatus = .lab
            changeLeftBtn(self.leftStatus)
            break
        case .start:
            self.watchStatus = .stop
            self.timer?.invalidate()
            self.timer = nil
            self.leftStatus = .reset
            changeLeftBtn(self.leftStatus)
            break
        }
    }
    
    // 랩 / 재설정 버튼 클릭 이벤트
    @IBAction func tchBtnLeft(_ sender: UIButton) {
        switch self.leftStatus {
        case .lab:
            break
        case .reset:
            self.watchStatus = .stop
            self.leftStatus = .disable
            
            self.timer?.invalidate()
            self.timer = nil
            
            self.accuTime = 0
            
            changeTimeLbl(formatTime(self.accuTime))
            
            changeControlBtn(.start)
            changeLeftBtn(.disable)
            break
        case .disable:
            break
        }
    }
    
    @objc func updateTimer() {
        self.accuTime += 0.01
        
        let timeSet = formatTime(self.accuTime)
        changeTimeLbl(timeSet)
    }
    
    // 초를 받아서 TimeSet으로 return 해주는 formatter
    func formatTime(_ time:Double) -> TimeSet {
        let hour = (Int)(fmod(time / 60 / 60, 12)) //시간 구하기
        let minute = (Int)(fmod(time / 60, 60)) // 분 구하기
        let second = (Int)(fmod(time, 60))
        let milliSecond = (Int)((time - floor(time)) * 100)
        
        let timeSet: TimeSet = TimeSet(hour: String(format: "%02d", hour), minute: String(format: "%02d", minute), second: String(format: "%02d", second), milliSecond: String(format: "%02d", milliSecond))
        
        return timeSet
    }
    
    // 시작 / 중단 버튼 변경 함수
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
    
    // 재설정 / 랩 버튼 변경 함수
    func changeLeftBtn (_ status: LeftStatus) {
        btnLeft.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        switch status {
        case .disable:
            btnLeft.isEnabled = false
            btnLeft.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 0.5)
            btnLeft.setTitle("랩", for: .normal)
            btnLeft.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.5), for: .normal)
            break
        case .lab:
            btnLeft.isEnabled = true
            btnLeft.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
            btnLeft.setTitle("랩", for: .normal)
            break
        case .reset:
            btnLeft.isEnabled = true
            btnLeft.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
            btnLeft.setTitle("재설정", for: .normal)
            break
        }
    }
    
    // 타이머 화면 변경해주는 함수
    func changeTimeLbl (_ timeSet: TimeSet) {
        lblMinute.text = timeSet.minute
        lblSecond.text = timeSet.second
        lblMiiliSecond.text = timeSet.milliSecond
    }
}
