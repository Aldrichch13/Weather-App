//
//  Perfil.swift
//  Weather App
//
//  Created by Aldrich  on 16/01/24.
//

import SwiftUI

struct Perfil: View {
    @State public var correo:String = ""
    @State public var telefono: String = ""
    @State private var navigationActive: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Circle().frame(width: 80, height: 80).foregroundColor(Color("azulClaro"))
                Image(systemName: "person.fill").resizable().frame(width: 50, height: 50).foregroundColor(.white)
            }.padding(.top,36)
            
            if let nombre = UserDefaults.standard.string(forKey: "userName"){
                Text("Bienvenido \(nombre)").padding(.top, 60).padding(.bottom)
            }
            TextField("Correo", text: $correo).overlay(Rectangle().frame(height: 1).padding(.top, 35)).padding(.horizontal).multilineTextAlignment(.center).padding()
            TextField("Telefono", text: $telefono).overlay(Rectangle().frame(height: 1).padding(.top, 35)).padding(.horizontal).multilineTextAlignment(.center).padding(.bottom,60).padding()
            
            
            Button {
                UserDefaults.standard.set(correo, forKey: "userMail")
                UserDefaults.standard.set(telefono, forKey: "userPhone")
                
            } label: {
                ZStack {
                    Rectangle().frame(height: 36).cornerRadius(4).foregroundColor(Color("morado"))
                    Text("ACTUALIZAR DATOS").foregroundColor(.white)
                }
            }.padding()
            
            
            Button {
                UserDefaults.standard.removeObject(forKey: "userName")
                UserDefaults.standard.removeObject(forKey: "userMail")
                UserDefaults.standard.removeObject(forKey: "userPhone")
                navigationActive = true

            } label: {
                ZStack {
                    Rectangle().frame(height: 36).cornerRadius(4).foregroundColor(Color("morado"))
                    Text("CERRAR SESIÓN").foregroundColor(.white)
                }
                
                
            }.padding()
            
            NavigationLink(destination: ContentView(), isActive: $navigationActive) {
                               EmptyView()
                           }
                           .hidden()

            
            Spacer()
            

        }
    }
}

struct Perfil_Previews: PreviewProvider {
    static var previews: some View {
        Perfil()
    }
}
