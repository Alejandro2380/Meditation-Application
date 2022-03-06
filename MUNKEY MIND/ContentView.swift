//
//  ContentView.swift
//  MUNKEY MIND
//
//  Created by Alejandro McGarvie on 3/1/22.
//

import SwiftUI
import AVKit
import AVFoundation

var player: AVAudioPlayer!


struct ContentView: View {
    var body: some View {
        
        //NavigationView{
        //yeah
            ZStack{
                ScrollView(.vertical, showsIndicators: false){
                    VStack (spacing: 15){
                        ForEach(1...8, id: \.self){i in
                            Image("p\(i)").resizable().frame(height:250).cornerRadius(15)
                        }
                    }.padding()
                }
               
                GeometryReader{_ in
                    HStack{
                        Menu()
                        Spacer()
                    }
                    
                }
                
            } .navigationBarTitle("Home", displayMode: .inline)
        
        
        ZStack{
            //LinearGradient(gradient: Gradient(colors: [.green, .white]),
                          // startPoint: .topLeading,
                        //   endPoint: .bottomTrailing)
                Color.teal
                .edgesIgnoringSafeArea(.all)
                //Spacer()
            
            
            
              VStack{
                  Image("Img1")
                      .resizable()
                      .scaledToFit()
                     .frame(width: 200 , height:200)
                
                
                  HStack{
                
                  Button(action:{
                      print("run")
                  }, label: {
                      Text("MEDITATIONS")
                          .foregroundColor(.black)
                        .frame(width:130, height: 30)
                        .background(.yellow)
                        //.border(Color.black, width: 3)
                        .cornerRadius(30)
                })
                    Button(action:{
                        print("run")
                    }, label: {
                        Text("HOW TO")
                            .foregroundColor(.black)
                            .frame(width:130, height: 30)
                            .background(.yellow)
                            //.border(Color.black, width: 3)
                            .cornerRadius(30)
                    })
                    Button(action:{
                        print("run")
                    }, label: {
                        Text("ABOUT US")
                            .foregroundColor(.black)
                            .frame(width:130, height: 30)
                            .background(.yellow)
                           // .border(Color.black, width: 3)
                           .cornerRadius(30)
                    })
                    
                 } //hstack closing
                Spacer()
               
            } //vstack closing

            VStack{
                Link(destination: URL(string: "https://www.youtube.com/watch?v=Kq3RSSivv-A")!, label: {
                    Text("Tiger Belly")
                        .bold()
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(15)
                })
                
                
                Link(destination: URL(string: "https://www.youtube.com/watch?v=Kq3RSSivv-A")!, label: {
                    Text("Tiger Belly")
                        .bold()
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(15)
                })
                
                
                Link(destination: URL(string: "https://www.youtube.com/watch?v=Kq3RSSivv-A")!, label: {
                    Text("Tiger Belly")
                        .bold()
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(15)
                })
                
                Link(destination: URL(string: "https://www.youtube.com/watch?v=Kq3RSSivv-A")!, label: {
                    Text("Tiger Belly")
                        .bold()
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(15)
                })
    
           }
        }//Vstacking closing
        
    }
    func playSouhd(){
        let url = Bundle.main.url(forResource: "Tada-sound", withExtension:"mp3")
        
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.play()
            
        } catch {
            print("error")
        }
    
    
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Menu: View {
    var body : some View{
        VStack(spacing: 35){
            Button(action:{
                
            }){
                VStack(spacing:8){
                    Image("home")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 55, height: 55)
                }
                
            }
            Button(action:{
                
            }){
                VStack(spacing:8){
                    Image("categories")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 55, height: 55)
                }
            }
            Button(action:{
                
            }){
                VStack(spacing:8){
                    Image("info")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 55, height: 55)
                }
               
            }
            Spacer(minLength: 15)
        }.padding(35)
            .background(Color("Color").edgesIgnoringSafeArea(.bottom))
}


}



//Button(action:{
  //  self.playSouhd()
//}, label: {
   // Text("5 Min Meditation")
     //   .foregroundColor(.black)
      //  .frame(width:350, height:60)
     //   .background(.white)
       // //.border(Color.black, width: 5)
///.cornerRadius(30)
     //   .padding(20)
        
//})


//Button(action:{
  //  print("Jacky")
//}, label: {
  //  Text("10 Min Meditation")
    //    .foregroundColor(.black)
      //  .frame(width:350, height:60)
        //.background(.white)
        //.border(Color.black, width:5)
        //.cornerRadius(30)
//})


//padding(5)


//Button(action:{
 //   print("Runny Nose")
//}, label:{
  //  Text("15 Min Meditation")
    //    .foregroundColor(.black)
      //  .frame(width:350, height:60)
        //.background(.white)
        //.border(Color.black,width:5)
       //.cornerRadius(30)
        //.padding(20)
        
//})

