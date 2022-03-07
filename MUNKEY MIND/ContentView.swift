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
    var body: some View {
       

        VStack{
            HStack{
          
                Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150 , height: 50)
                Spacer()
            }
        }

        ZStack{
       
            NavigationView{
               
            
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [.yellow, .white]),
                                   startPoint: .topLeading,
                                  endPoint: .bottomTrailing)
//                    Color.yellow //main screen app background
//                   .edgesIgnoringSafeArea(.all)
                   
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
                                        //.foregroundColor(.white)
                                       // .background(.white)
                                    }
                                      
                            })
                    )
             
                }

            
            VStack(spacing: 55){
             
            
                Link(destination: URL(string: "https://www.youtube.com/watch?v=Kq3RSSivv-A")!, label: {
                    Text("5 Min Meditation")
                    .bold()
                    .frame(width: 150, height: 50)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(15)
                })
        
        
                Link(destination: URL(string: "https://www.youtube.com/watch?v=Kq3RSSivv-A")!, label: {
                    Text("10 Min Meditation")
                        .bold()
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(15)
                })
        
        
                Link(destination: URL(string: "https://www.youtube.com/watch?v=Kq3RSSivv-A")!, label: {
                    Text("15 Min Meditation")
                        .bold()
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(15)
                })
        
                Link(destination: URL(string: "https://www.youtube.com/watch?v=Kq3RSSivv-A")!, label: {
                    Text("Customer Meditation")
                        .bold()
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(15)
                })
            
            }
         
        }
      
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
            VStack(spacing: 60){
                Button(action:{
                    
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
            .background(Color("Color").edgesIgnoringSafeArea(.bottom))
    }


}

//LinearGradient(gradient: Gradient(colors: [.green, .white]),
              // startPoint: .topLeading,
            //   endPoint: .bottomTrailing)
