//
//  VideosMeta.swift
//  VideoPlayer
//
//  Created by dt on 14/06/2022.
//

import Foundation
import AVFoundation

class VideosMetaGrabber{
    
    var vids:[VidInfo] = []
    var current:Int = 0
    var delay:Double = 5
    
    init (){
        if let localData = self.readLocalFile(forName: "vids") {
            print(localData)
                    self.parse(jsonData: localData)
                }
                
    }
    
//    func getData() -> [VidInfo]{
//        let localData = self.readLocalFile(forName:"vids")
//        self.parse(jsonData:localData)
//        
//    }
    func setDelay(d:Double){
        self.delay = d
    }
    
private func readLocalFile(forName name: String) -> Data? {
       do {
           if let bundlePath = Bundle.main.path(forResource: name,
                                                ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
               return jsonData
           }
       } catch {
           print(error)
       }
       
       return nil
   }
    
    func playNext()->VidInfo{
        if(current == vids.count){
            current = 0
        }
       // vids[current].item?.seek(to: CMTime.zero)
        let v = vids[current]
        current += 1
        makeRunList()
        return v
        
        
    }
    
    
    func makeRunList(){
        var cumulator = current
        var time = Date()
        print(time)
        var plist:[playListInfo] = []
        for _ in 0 ... 8{
            if(cumulator == vids.count){
                cumulator = 0
            }
           // print(vids[cumulator].item!.duration.seconds)
            time = time + Double(vids[cumulator].item!.duration.seconds)
            time = time.addingTimeInterval(Double(delay+3))
           
            let df = DateFormatter()
            df.dateFormat = "HH:mm"
            let p = playListInfo(title: vids[cumulator].title, name: vids[cumulator].name, time: df.string(from: time) )
            plist.append(p)
            cumulator += 1
           
        }
       /// print(plist)
        do {
           
            let data = try JSONEncoder().encode(plist)
            if var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                url.appendPathComponent("reports.json")
               // print(url)
                try data.write(to: url)
            }
        } catch {
            print(error)
        }
        
    }
    
    
//   
//   private func loadJson(fromURLString urlString: String,
//                         completion: @escaping (Result<Data, Error>) -> Void) {
//       if let url = URL(string: urlString) {
//           print("url String \(url)")
//           let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
//               if let error = error {
//                   completion(.failure(error))
//               }
//               
//               if let data = data {
//                   completion(.success(data))
//               }
//           }
//           
//           urlSession.resume()
//       }
//   }

   private func parse(jsonData: Data) {
       do {
           print(jsonData)
          let decodedData:[JSONIN] = try JSONDecoder().decode([JSONIN].self,
                                                     from: jsonData)
           //let blogPosts: [JSONIN] = try! JSONDecoder().decode([JSONIN].self, from: jsonData)
           for vi in decodedData{
               print(vi.filename)
               let item = loadVideo(filename: vi.filename)
               let vidInfo = VidInfo(title: vi.title, filename: vi.filename, name: vi.name, item: item)
               vids.append(vidInfo)
           }
       } catch {
           print("decode error")
       }
   }
    
         private func loadVideo(filename:String)->AVPlayerItem{
            
             let fileUrl = Bundle.main.url(forResource: filename, withExtension: nil)
             let asset = AVAsset(url: fileUrl!)
             asset.duration.seconds
             return AVPlayerItem(asset: asset)
    }
}

struct JSONIN: Codable {
    let title: String
    let filename: String
    let name: String
}

struct VidInfo{
    let title: String
    let filename: String
    let name: String
    let item:AVPlayerItem?
   
}

struct playListInfo:Encodable{
    let title: String
    let name: String
    let time: String
}


    

