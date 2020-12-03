//
//  MusicHelper.swift
//  Docust
//
//  Created by sage on 2020/11/17.
//  Copyright © 2020 sage. All rights reserved.
//

import AVFoundation

class MusicHelper {
    static let sharedHelper = MusicHelper()
    var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic() {
        if BgData.musicOn && MusicHelper.sharedHelper.chooseMusic() != nil{
            guard let aSound = Bundle.main.url(forResource:chooseMusic()!, withExtension: "m4a") else { return }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
                audioPlayer!.numberOfLoops = -1
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            } catch {
                print("Cannot play the file")
            }
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
}
