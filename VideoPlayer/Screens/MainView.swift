//
//  MainView.swift
//  VideoPlayer
//
//  Created by Catalin Patrascu on 11.03.2022.
//
//  Distributed under the MIT License

import SwiftUI
import AVFoundation


struct MainView: View {
    @State private var player = AVQueuePlayer()
    @State private var showingSheet = false
    @State private var sliderVal:Double = 5

   
                
            
    var body: some View {
       
        ZStack(alignment: .center) {
                
            PlayerView(player: player, sliderVal: $sliderVal).onTapGesture{
               
                NSCursor.unhide()
                showingSheet.toggle()
               
            }.fullScreenCover(isPresented: $showingSheet) {
                SheetView(sliderVal: $sliderVal).background(.white)
            }
         
            

//            if(showTitles){
//                    HStack(){
//                        Spacer()
//                    VStack(alignment: .leading) {
//                                Spacer()
//                        Spacer()
//                        
//                        Spacer()
//                        Text("title text")
//                            .fontWeight(.bold)
//                            .font(.system(size: 100))
//                        
//                                Text("This is a longer line of text")
//                            .fontWeight(.semibold)
//                            .font(.system(size: 80))
//                        Spacer()
//                            }
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                    }
//                }
            }
        }
    }
    
struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var sliderVal: Double
    var body: some View {
        
      
        VStack{
          //  Spacer()
            
            Slider(value: $sliderVal, in: 0...20).padding()
            Text("Time Delay to view Titles: \(Int(sliderVal))").fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(.black)
                .padding()
            Spacer()
            Text("Make this window fullscreen and then Press button below to hide the cursor")
                                        .fontWeight(.bold)
                                        .font(.system(size: 20))
                                        .foregroundColor(.black)
                                        .padding()
            //Text(Date())
        
        Button("Press to Hide") {
            NSCursor.hide()
            dismiss()
            
            
        }
        .font(.title)
        .padding()
        .background(.white)
        .padding()
            Spacer()
        }.padding()
        
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
