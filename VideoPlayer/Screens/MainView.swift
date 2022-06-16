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
   
   
   
                
            
    var body: some View {
       
        ZStack(alignment: .center) {
                
                FullScreenVideo()
           

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
    
//    private func makeNavigationLink() -> some View {
//        NavigationLink(
//            destination: SecondView(),
//            isActive: $goNextTapped,
//            label: { EmptyView() }
//        )
//    }


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
