//
//  ContentView.swift
//  Weather App
//
//  Created by Aldrich  on 16/01/24.
//

import SwiftUI

struct ContentView: View {
    
    @State public var userName: String = ""
    @State public var biometricosActivados: Bool = false
    @StateObject private var weatherViewModel = WeatherViewModel()

    
    var body: some View {

                NavigationView{
                VStack (alignment:.leading) {
                    Text("Bienvenido!").font(.largeTitle).frame(maxWidth: .infinity).padding(.bottom, 240).padding(.top).frame(alignment: .center).foregroundColor(.gray)
                    
                    Text("Ingresa tu nombre").foregroundColor(.gray)
                    TextField("Nombre", text: $userName).padding(.bottom,24)
                    
                    if !userName.isEmpty {
                        NavigationLink(destination: Principal()){
                            ZStack {
                                Rectangle().frame( height: 36).cornerRadius(4).foregroundColor(Color("morado"))
                                Text("INGRESAR").foregroundColor(.white)
                            }
                        }
                    } else {
                        ZStack {
                            Rectangle().frame(height: 36).cornerRadius(4).foregroundColor(Color("morado"))
                            Text("INGRESAR").foregroundColor(.white)
                        }
                    }
                    
                    Toggle("Habilitar biometricos", isOn: $biometricosActivados).padding(.leading,120).padding(.top,120)
                    
                    Spacer()
                }
                .padding()
                .onDisappear{
                    UserDefaults.standard.set(userName, forKey: "userName")
                }
                    
                
                    
                }.navigationBarBackButtonHidden()
            
        .onAppear {weatherViewModel.requestLocation()}
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
