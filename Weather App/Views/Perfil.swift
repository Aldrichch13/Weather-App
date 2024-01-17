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
    @State private var imagenPerfil: UIImage?
    @State private var mostrarImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    

    
    var body: some View {
        VStack {
            ZStack {
                Circle().frame(width: 80, height: 80).foregroundColor(Color("azulClaro"))

                if let imagen = imagenPerfil {
                    Image(uiImage: imagen)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                    
                }


            }.padding(.top,36)
            
            HStack {
                Button("Seleccionar Foto") {
                    sourceType = .photoLibrary
                    mostrarImagePicker.toggle()
                }.padding()
                
                Button("Tomar Foto") {
                    sourceType = .camera
                    mostrarImagePicker.toggle()
                    }.padding()

                .sheet(isPresented: $mostrarImagePicker, onDismiss: guardarImagen) {
                    ImagePicker(imagenSeleccionada: $imagenPerfil, sourceType: sourceType)
                    }
                
                }
            
            if let nombre = UserDefaults.standard.string(forKey: "userName"){
                Text("Bienvenido \(nombre)").padding(.top, 60).padding(.bottom)
            }
            TextField("Correo", text: $correo).keyboardType(.emailAddress).overlay(Rectangle().frame(height: 1).padding(.top, 35)).padding(.horizontal).multilineTextAlignment(.center).padding()
            TextField("Telefono", text: $telefono).keyboardType(.numberPad).overlay(Rectangle().frame(height: 1).padding(.top, 35)).padding(.horizontal).multilineTextAlignment(.center).padding(.bottom,60).padding()
            
            
            Button {
                UserDefaults.standard.set(correo, forKey: "userMail")
                UserDefaults.standard.set(telefono, forKey: "userPhone")
                correo = ""
                telefono = ""
                
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
                UserDefaults.standard.removeObject(forKey: "imagenPerfil")
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
    
    private func cargarImagenGuardada() {
        if let imageData = UserDefaults.standard.data(forKey: "imagenPerfil"),
           let uiImage = UIImage(data: imageData) {
            imagenPerfil = uiImage
        }
    }

    private func guardarImagen() {
        if let imagen = imagenPerfil,
           let imageData = imagen.pngData() {
            UserDefaults.standard.set(imageData, forKey: "imagenPerfil")
        }
    }
}

struct Perfil_Previews: PreviewProvider {
    static var previews: some View {
        Perfil()
    }
}
