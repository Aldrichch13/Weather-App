//
//  Scroll.swift
//  Weather App
//
//  Created by Aldrich  on 16/01/24.
//


import SwiftUI
import SwiftUIRefresh

struct Scroll: View {
    @State private var data: [String] = ["Dato 1", "Dato 2", "Dato 3"]
    @State private var isRefreshing: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(data, id: \.self) { dato in
                        Text(dato)
                    }
                }
            }
            .refreshable {
                // Función que se ejecutará al jalar hacia abajo para actualizar
                await actualizarDatos()
            }

        }
    }

    func actualizarDatos() async {
        // Simula la carga de nuevos datos (puedes implementar tu lógica de actualización aquí)
        await Task.sleep(2_000_000_000) // Simula una espera de 2 segundos
        data.append("Nuevo Dato")
    }
}

struct Scroll_Previews: PreviewProvider {
    static var previews: some View {
        Scroll()
    }
}
