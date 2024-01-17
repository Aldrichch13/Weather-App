//
//  Principal.swift
//  Weather App
//
//  Created by Aldrich  on 16/01/24.
//

import SwiftUI

struct Principal: View {
    var body: some View {
        
        
        NavigationView{
            TabView{
                Clima()
                    .tabItem {
                        Image(systemName: "sun.min.fill")
                        Text("Clima")
                    }
                Perfil()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Perfil")
                    }
            }
        }.navigationBarBackButtonHidden()

    }
}

struct Principal_Previews: PreviewProvider {
    static var previews: some View {
        Principal()
    }
}
