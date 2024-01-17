//
//  prueba.swift
//  Weather App
//
//  Created by Aldrich  on 16/01/24.
//

import SwiftUI

import UIKit

struct prueba: View {
    @State private var imagenPerfil: UIImage?
    @State private var mostrarImagePicker: Bool = false

    var body: some View {
        
        VStack {
            if let imagen = imagenPerfil {
                Image(uiImage: imagen)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }

            Button("Seleccionar Foto") {
                mostrarImagePicker.toggle()
            }
            .padding()
            .sheet(isPresented: $mostrarImagePicker, onDismiss: guardarImagen) {
                ImagePicker(imagenSeleccionada: $imagenPerfil)
            }
        }
        .onAppear(perform: cargarImagenGuardada)
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

struct prueba_Previews: PreviewProvider {
    static var previews: some View {
        prueba()
    }
}
