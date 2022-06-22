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
    @State private var currentVal:Int = 0

   
                
            
    var body: some View {
       
        ZStack(alignment: .center) {
                
            PlayerView(player: player, sliderVal: $sliderVal, currentVal: $currentVal).onTapGesture{
               
                NSCursor.unhide()
                showingSheet.toggle()
               
            }.fullScreenCover(isPresented: $showingSheet) {
                SheetView(sliderVal: $sliderVal, currentVal: $currentVal).background(.white)
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
    @Binding var currentVal: Int
    var body: some View {
        
      
        VStack{
          //  Spacer()
            
            Slider(value: $sliderVal, in: 0...20).padding()
            Text("Time Delay to view Titles: \(Int(sliderVal))").fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(.black)
                .padding()
            Spacer()
            Text("Set the video to play next")
                        Slider(value: IntDoubleBinding($currentVal).doubleValue, in: 0.0...25.0, step: 1.0)
            Text("Choose Video: \(Int(currentVal))").fontWeight(.bold)
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

struct IntDoubleBinding {
    let intValue : Binding<Int>
    
    let doubleValue : Binding<Double>
    
    init(_ intValue : Binding<Int>) {
        self.intValue = intValue
        
        self.doubleValue = Binding<Double>(get: {
            return Double(intValue.wrappedValue)
        }, set: {
            intValue.wrappedValue = Int($0)
        })
    }
}
