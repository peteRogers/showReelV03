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
   
    
    
    
    private let player: AVQueuePlayer
    
    init(player: AVQueuePlayer) {
        
        self.player = player
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) { }

    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView( player: player)
    }
}
