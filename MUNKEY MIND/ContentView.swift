//
//  ContentView.swift
//  MUNKEY MIND
//
//  Created by Alejandro McGarvie on 3/1/22.
//
//                Color.teal
//                .edgesIgnoringSafeArea(.all)
import SwiftUI
import AVKit
import AVFoundation

var player: AVAudioPlayer!

   
struct ContentView: View {
    
    @State var show = false
    @State var startPlayer = false
    
    var body: some View {
        
        VStack{
            HStack{
          
                Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150 , height: 50)
               
                Spacer()
            }
            .background(Color("sky-blue"))
        }

        ZStack{
       
            NavigationView{
                
            
                ZStack{
//
                  Color("light-orange") //main screen app background
//
                   
                        ScrollView(.vertical, showsIndicators: false){
                            
                            VStack (spacing: 15){
                                
                                ForEach(1...8, id: \.self){i in
                                    
                                    Image("p\(i)").resizable().frame(height:250).cornerRadius(15)
                                }
                            }.padding()
                        }
                            GeometryReader {_ in
               
                                HStack{
                                    
                                    Menu()
                                        .offset(x: self.show ? 0 : -UIScreen.main.bounds.width)
                                        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6), value: 0.5)
                                    Spacer()
                                }
                                    
                            } .background(Color.black.opacity(self.show ? 0.5 : 0).edgesIgnoringSafeArea(.bottom))

                        
                    }.navigationBarTitle("", displayMode: .inline)
                    .navigationBarItems(leading:
                                            
                         Button(action: {
                        
                            self.show.toggle()
                                }, label: {
                                   
                                    if self.show{
                                        Image("Back-Arrow-1")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                    }
                                    else{
                                    Image("hamburger-menu").renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35, height: 35)
                                    }
                                
                            })
                    )
             
                
            }


                Button(action:{
                    startPlayer = true

                }){
                    if startPlayer == false {
                        Image("home")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 35, height: 35)

                        Text("Home")

                    } else {


                        MusicPlayer().navigationTitle("Music Player")
                                   
                    }
                }
        }
    }
}




struct MusicPlayer: View{
    
    @State var data : Data = .init(count:0)
    @State var title = ""
    @State var player : AVAudioPlayer!
    @State var playing = false
    @State var width : CGFloat = 0
    @State var songs = ["Trac 3", "Track 2"]
    @State var current = 0
    @State var finish = false
    @State var del = AVdelegate()

    
    var body : some View {
        
        VStack(spacing: 20){
            Image(uiImage: self.data.count == 0 ? UIImage(named: "Stars")!:UIImage(data: self.data)!)
                .resizable()
                .frame(width: self.data.count == 0 ? 250 : nil, height: 250)
                   .cornerRadius(15)
            
            Text(self.title).font(.title).padding(.top)
            
            ZStack(alignment: .leading ){
                
                Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
                
                Capsule().fill(Color.red).frame(width: self.width, height: 8)
                
                    .gesture(DragGesture()
                    .onChanged({ (value) in
                        
                        let x = value.location.x
                        
                        self.width = x
                        
                        
                    }).onEnded ({ (value) in
                        
                        let x = value.location.x
                        
                        let screen = UIScreen.main.bounds.width - 30
                        
                        let percent = x / screen
                        
                        self.player.currentTime = percent *
                        self.player.duration
                        
                    }))
            }
            .padding(.top)
            
            HStack(spacing: 40){
                Button(action:{
                    
                    if self.current > 0 {
                        
                        self.current -= 1
                        
                        self.songChanger()
                    }
                    
                }){
                    Image(systemName: "backward.fill").font(.title)
                    
                }
                
                Button(action:{
                    
                    self.player.currentTime -= 15
                    
                    
                }){
                    Image(systemName: "gobackward.15").font(.title)
                    
                }
                
                Button(action:{
                    
                    if self.player.isPlaying{
                        
                        self.player.pause()
                        self.playing = false
                    }
                    else{
                        
                        if self.finish{
                            
                            self.player.currentTime = 0
                            self.width = 0
                            self.finish = false
                        }
                        
                        self.player.play()
                        self.playing = true
                    }
                    
                }){
                    Image(systemName: self.playing && !self.finish ?  "pause.fill" : "play.fill").font(.title)
                    
                }
                
                Button(action:{
                    
                    let increase = self.player.currentTime + 15
                    
                    if increase < self.player.duration{
                        
                        self.player.currentTime = increase
                    }
                    
                }){
                    Image(systemName: "goforward.15").font(.title)
                    
                }
                
                Button(action:{
                    
                    if self.songs.count - 1 != self.current{
                        
                        self.current += 1
                        
                        self.songChanger()
                    }
                    
                }){
                    Image(systemName: "forward.fill").font(.title)
                    
                }
                
    
            }.padding(.top, 25)
                .foregroundColor(.black)
        
        }.padding()
       .onAppear {
           
           let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
           
           self.player = try! AVAudioPlayer(contentsOf:  URL(fileURLWithPath: url!))
           
           self.player.delegate = self.del
           
           
           self.player.prepareToPlay()
           self.getData()
           
           Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (true) in
               if self.player.isPlaying{
                   
                   let screen = UIScreen.main.bounds.width - 30
                   
                   let value = self.player.currentTime / self.player.duration
                   
                   self.width = screen * CGFloat(value)
               }
               
           }
           
           NotificationCenter.default.addObserver(forName:
                           NSNotification.Name("Finish"), object: nil, queue: .main) { (true) in
               self.finish = true
               
           }
           
       }
   }
    

    func getData() {
        

        let asset = AVAsset(url: self.player.url!)
        
        for i in asset.commonMetadata{
            
            if i.commonKey?.rawValue == "Stars"{
                
                let data = i.value as! Data
                self.data = data
            }
            
            if i.commonKey?.rawValue == "title"{
                
                let title = i.value as! String
                self.title = title
            }
        }
    
    }
    
    
    
    func songChanger(){
        let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
        
        self.player = try! AVAudioPlayer(contentsOf:  URL(fileURLWithPath: url!))
        
        self.player.delegate = self.del
        
        
        self.data = .init(count: 0)
        
        self.title = ""
        
        self.player.prepareToPlay()
        self.getData()
        
        self.playing = true
        
        self.finish = false
        
        self.width = 0
        
        self.player.play()
        
        
    }

}

class AVdelegate : NSObject, AVAudioPlayerDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        NotificationCenter.default.post(name: NSNotification.Name("Finish"), object:
        nil)
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Menu: View {
    var body : some View{
            VStack(spacing: 60){
                Button(action:{
                    //Home()
                }){
                    VStack(spacing:8){
                        Image("home")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 35, height: 35)
                        Text("Home")
                    }
                    
                }
                Button(action:{
                    
                }){
                    VStack(spacing:8){
                        Image("categories")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 35, height: 35)
                        Text("Categories")
                    }
                }
                
                Button(action:{
                    
                }){
                    VStack(spacing:8){
                        Image("diversity")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 35, height: 35)
                        Text("Join Our Community")
                    }
                }
                
                Button(action:{
                
                }){
                    VStack(spacing:8){
                        Image("info")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 35, height: 35)
                        Text("About Us")
                    }
               
                }
                Spacer(minLength: 15)
            }.padding(35)
            .background(Color("light-green").edgesIgnoringSafeArea(.bottom))
    }
    
    
        
}








//                Link(destination: URL(string: "https://www.youtube.com/watch?v=Kq3RSSivv-A")!, label: {
//
//                    Text("5 Min Meditation")
//                 // Text("5 ") + Text( Image(systemName: "clock")) + Text("Min ") +  Text("Meditation" )
//
////
//                    .bold()
//                    .frame(width: 150, height: 50)
//                    .foregroundColor(.white)
//                    .background(.black)
//                    .cornerRadius(15)
//                })
//
//




