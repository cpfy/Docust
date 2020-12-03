//
//  StartViewController.swift
//  Docust
//
//  Created by sage on 2020/11/4.
//  Copyright © 2020 sage. All rights reserved.
//

import UIKit
import AVFoundation

enum WorkoutState {
    case inactive
    case active
    case paused
}

class StartViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var bossTime : Times = Times()
    var workoutState = WorkoutState.inactive
    var timer = Timer()
    var letSecond = 12
    var second = 12
    
    var rds : RandomSelection = RandomSelection()
    //var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initWelcomeLabel()
        resetParameter()
        refreshBackgroundImage()
    }
    
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        refreshBackgroundImage()
    }
    
    func refreshBackgroundImage(){
        if getBgName() != nil{
            let img = UIImage(named: getBgName()!)
            self.view.layer.contents = img?.cgImage
            
            //(废弃的做法，图片重复)self.view.backgroundColor = UIColor(patternImage: UIImage(named: getBgName()!)!)
            /*(废弃的做法2，只能改一次图)
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: getBgName()!)
            backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
            self.view.insertSubview(backgroundImage, at: 0)
            */
        }
        else{
            self.view.backgroundColor = .white
        }
    }
    
    func initWelcomeLabel(){
        welcomeLabel.text = bossTime.getWelcomeText()
    }
    
    func resetParameter(){
        startButton.setTitle("开始", for: .normal)
        workoutState = .inactive
        second = letSecond
        updateTimerLabel()
        //stopMusic()
    }
    
    func updateSettingTime(min : Int){
        let sec = min * 60
        letSecond = sec
        second = sec
        updateTimerLabel()
    }
    
    @IBAction func pressTimeChangeBtn(_ sender: UIBarButtonItem) {
        print("TimeChange Button is pressed.")
        presentTimeChangeAlert()
    }
    
    @IBAction func pressStartBtn(_ sender: UIButton) {
        if(workoutState == .inactive){
            workoutState = .active
            startTimer()
            MusicHelper.sharedHelper.playBackgroundMusic()
            startButton.setTitle("放弃",for:.normal)
            print("Start Button is pressed.")
        }
        else if (workoutState == .active){
            presentSuspendAlert()
            timer.invalidate()
        }
    }
    /*
    func playMusic(){
        if BgData.musicOn && MusicHelper.sharedHelper.chooseMusic() != nil{
            MusicHelper.sharedHelper.playBackgroundMusic()
        }
    }*/
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updataSecond), userInfo: nil, repeats: true)
        //调用fire()会立即启动计时器
        timer.fire()
    }
    
    // 3.定时操作
    @objc func updataSecond() {
        print(second)
        if second > 0 {
            //.........
            second -= 1
            updateTimerLabel()
        }else {
            succeed()
            stopTimer()
        }
    }
    
    func stopTimer() {
        timer.invalidate() //销毁timer
    }
    
    func updateTimerLabel() {
        //let interval = letSecond + Int(startDate.timeIntervalSinceNow)
        let interval = second
        let minutes = interval / 60 % 60
        let seconds = interval % 60
        
        timeLabel.text = String(format:"%02i:%02i", minutes, seconds)
    }
    
    func GiveUpButtonPressed(){
        timer.invalidate()
        workoutState = .paused
        presentSuspendAlert()
    }
    
    
    
    func succeed(){
        print("succeed!")
        presentSucceedAlert()
        timer.invalidate()
        resetParameter()
        updateStats(dt:dt, sec:letSecond*60)
    }
    
    func failed(){
        print("failed.")
        timer.invalidate()
        resetParameter()
    }
    
    func continueCounting(){
        print("continue counting.")
        startTimer()
    }
    
    func presentSucceedAlert(){
        rds.initRarityPool()
        let strSuccess = rds.unlockADot()
        
        let succeedMessage = UIAlertController(title: "专注成功", message: strSuccess, preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "确定", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        //Add OK button to a dialog message
        succeedMessage.addAction(ok)
        // Present Alert to
        self.present(succeedMessage, animated: true, completion: nil)
    }
    
    func presentSuspendAlert(){
        let suspendMessage = UIAlertController(title: "警告", message: "确定放弃专注吗?", preferredStyle: .alert)
        // Create OK button with action handler
        let ok = UIAlertAction(title: "确定", style: .destructive, handler: { (action) -> Void in
            print("Ok button tapped")
            self.failed()
        })
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
            self.continueCounting()
        }
        //Add OK and Cancel button to an Alert object
        suspendMessage.addAction(ok)
        suspendMessage.addAction(cancel)
        // Present alert message to user
        self.present(suspendMessage, animated: true, completion: nil)
    }
    
    func presentTimeChangeAlert(){
        let dialogMessage = UIAlertController(title: "添加时间", message: "", preferredStyle: .alert)
        // Add text field
        dialogMessage.addTextField(configurationHandler: { textField in
            textField.placeholder = "请输入新的时间（单位：分钟）"
        })
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            print("PIN code typed = \(dialogMessage.textFields?.first?.text ?? "")")
            self.updateSettingTime(min : Int(dialogMessage.textFields?.first?.text ?? "0") ?? 0)
        })
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        // Present alert message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    
    
    func getBgName() -> String?{
        switch(BgData.selectedBgIndex){
            case 0: return nil
            case 1: return "Pic-GreenWind"
            case 2: return "Pic-YellowCloud"
            case 3: return "Pic-BlueUniverse"
            case 4: return "Pic-GuanShan"
            case 5: return "Pic-ChangHe"
            case 6: return "Pic-ZiDian"
            default: return nil
        }
    }
    
    
    
    /*
    func playBackgroundMusic() {
        guard let aSound = Bundle.main.url(forResource:chooseMusic()!, withExtension: "m4a")
        else { print("can't found music!")
            return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
    }
    
    func chooseMusic() -> String?{
    switch(BgData.selectedMusicIndex){
        case 0: return nil
        case 1: return "Genshin"
        case 2: return "Cytus2"
        default: return nil
        }
    }
    
    func stopMusic(){
        if audioPlayer != nil{
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0
            print("music stopped.")
        }
        else{print("audioPlayer is nil")}
    }*/
    
    /*废弃的思路
    func startTimer(){
        var timeCount = bossTime.totalTimeOfSecond       // 剩余时间计数
        var remainTimeString : String = ""
        var inSuspend = false
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())       // 在global线程里创建一个时间源
        timer.schedule(deadline: .now(), repeating: .seconds(1))    // 设定这个时间源是每秒循环一次，立即开始
        // 设定时间源的触发事件
        timer.setEventHandler(handler: {
            if timeCount <= 0 || self.cancelTimer {
                timer.cancel()
                print("Timer canceled.")
            }
            
            else if self.paused{
                timer.suspend()
                inSuspend = true
                print("have paused.")
            }
            else if (!self.paused) && inSuspend{
                inSuspend = false
                print("resume!")
                timer.resume()
            }

            timeCount = timeCount - 1
            // 时间到了取消时间源
            
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                print("remainTime:\(timeCount)");
                remainTimeString = self.bossTime.updateTimeLabel(num: timeCount)
                self.timeLabel.text = remainTimeString
                
                if(timeCount <= 0){
                    self.succeed()
                }
                
                if self.paused{
                    self.alreadySuspend = true
                }
                else if (!self.paused) && (self.alreadySuspend){
                    self.alreadySuspend = false
                }
            }
        })
        timer.resume() // 启动时间源
    }*/
}
