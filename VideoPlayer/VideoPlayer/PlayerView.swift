//
//  PlayerView.swift
//  VideoPlayer
//
//  Created by Catalin Patrascu on 11.03.2022.
//
//  Distributed under the MIT License

import SwiftUI
import AVFoundation

struct PlayerView: UIViewRepresentable {
   
    
    
    @Binding var sliderVal: Double
    @Binding var currentVal: Int
    private let player: AVQueuePlayer
    
    init(player: AVQueuePlayer, sliderVal: Binding<Double>, currentVal: Binding<Int> ) {
        
        self.player = player
        self._sliderVal = sliderVal
        self._currentVal = currentVal
        //print(sliderVal)
        
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
        let v:LoopingPlayerUIView = uiView as! LoopingPlayerUIView
        v.sliderVal = sliderVal
       // v.currentVal = currentVal
        v.setCurrentPosition(current: currentVal)
        
        
    }
    
  
    

    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView( player: player, sliderVal: sliderVal, currentVal: currentVal)
    }
}
