//
//  Clima.swift
//  Weather App
//
//  Created by Aldrich  on 16/01/24.
//

import SwiftUI
import SwiftUIRefresh

struct Clima: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    @State private var firstTime = false
        var body: some View {
            
            
            
            VStack {
                if let nombre = UserDefaults.standard.string(forKey: "userName"){
                    Text("Hola \(nombre)").padding()
                }else{
                    Text("Hola!").padding()
                }
                
                ScrollView{
                    VStack {
                        
                        HStack (spacing: 24){
                            
                            ZStack {
                                Rectangle().frame(height: 100).foregroundColor(.white).shadow(radius: 5)
                                HStack {
                                    Image(systemName: "cloud.sun").resizable().frame(width: 60, height: 60)
                                    VStack(alignment: .trailing) {
                                        Text("Weather").fontWeight(.bold).padding(.bottom)
                                        if let weatherData = weatherViewModel.weatherData{
                                            Text(String(format: "%.1f", weatherData.current.tempC)+" °C")
                                        } else {
                                            Text("Cargando").fontWeight(.thin)
                                        }
                                    }.padding(.leading,20)
                                }
                            }
                            
                            ZStack {
                                Rectangle().frame(height: 100).foregroundColor(.white).shadow(radius: 5)
                                HStack {
                                    Image(systemName: "humidity").resizable().frame(width: 60, height: 60)
                                    VStack (alignment: .trailing){
                                        Text("Degree").fontWeight(.bold).padding(.bottom)
                                        if let weatherData = weatherViewModel.weatherData{
                                            Text(String(format: "%.1f", weatherData.current.humidity)+" %")
                                        } else {
                                            Text("Cargando").fontWeight(.thin)
                                        }
                                    }.padding(.leading,20)
                                }
                            }
                            
                        }.padding(.horizontal).padding(.top)
                        
                        HStack (spacing: 24){
                            
                            ZStack {
                                Rectangle().frame(height: 100).foregroundColor(.white).shadow(radius: 5)
                                HStack {
                                    Image(systemName: "thermometer.medium").resizable().frame(width: 40, height: 60).padding(.leading,4)
                                    VStack (alignment: .trailing){
                                        if let weatherData = weatherViewModel.weatherData{
                                            if let firstForecastDay = weatherData.forecast.forecastday.first{
                                                Text(String(format: "%.1f", firstForecastDay.day.maxtempC)+" °C Max").fontWeight(.bold).padding(.bottom)
                                            }
                                        } else {
                                            Text("Cargando").fontWeight(.thin).padding(.bottom)
                                        }
                                        
                                        if let weatherData = weatherViewModel.weatherData{
                                            if let firstForecastDay = weatherData.forecast.forecastday.first{
                                                Text(String(format: "%.1f", firstForecastDay.day.mintempC)+" °C Min")
                                            }
                                        } else {
                                            Text("Cargando").fontWeight(.thin)
                                        }

                                    }.padding(.leading,20)
                                }
                            }
                            
                            ZStack {
                                Rectangle().frame(height: 100).foregroundColor(.white).shadow(radius: 5)
                                HStack {
                                    Image(systemName: "wind").resizable().frame(width: 50, height: 50)
                                    VStack (alignment: .trailing){
                                        Text("Wind").fontWeight(.bold).padding(.bottom)
                                        if let weatherData = weatherViewModel.weatherData{
                                            Text(String(format: "%.1f", weatherData.current.windKph)+" Km/hr")
                                        } else {
                                            Text("Cargando").fontWeight(.thin)
                                        }
                                    }.padding(.leading,20)
                                }
                            }
                            
                        }.padding(.horizontal)
                        
                        ZStack {
                            Rectangle().frame(height: 172).padding().foregroundColor(.white).shadow(radius: 5)
                            VStack{
                                HStack(spacing: 140){
                                    Image(systemName: "map").resizable().frame(width: 60, height: 60).padding(.trailing)
                                    VStack(alignment: .trailing) {
                                        if let weatherData = weatherViewModel.weatherData{
                                            Text(weatherData.location.name).padding(.bottom,4)
                                        } else {
                                            Text("Cargando").fontWeight(.thin).padding(.bottom,4)
                                        }
                                        
                                        if let weatherData = weatherViewModel.weatherData{
                                            Text(weatherData.location.region)
                                        } else {
                                            Text("Cargando").fontWeight(.thin)
                                        }
                                        

                                    }
                                }.padding(.bottom)
                                HStack(spacing: 28){
                                    Image(systemName: "sunrise").resizable().frame(width: 48, height: 48)
                                    VStack(alignment: .trailing){
                                        Text("Sunrise").padding(.bottom,4)
                                        if let weatherData = weatherViewModel.weatherData{
                                            if let firstForecastDay = weatherData.forecast.forecastday.first{
                                                Text(firstForecastDay.astro.sunrise).fontWeight(.bold).padding(.bottom,4)
                                            }
                                        } else {
                                            Text("Cargando").fontWeight(.thin).fontWeight(.bold).padding(.bottom,4)
                                        }
                                    }
                                    Image(systemName: "sunset").resizable().frame(width: 48, height: 48)
                                    VStack(alignment: .trailing){
                                        Text("Sunset").padding(.bottom,4)
                                        if let weatherData = weatherViewModel.weatherData{
                                            if let firstForecastDay = weatherData.forecast.forecastday.first{
                                                Text(firstForecastDay.astro.sunset).fontWeight(.bold).padding(.bottom,4)
                                            }
                                        } else {
                                            Text("Cargando").fontWeight(.thin).fontWeight(.bold).padding(.bottom,4)
                                        }
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                    }
                }
                .refreshable {
                    // Función que se ejecutará al jalar hacia abajo para actualizar
                    await actualizarDatos()
                }

            .onAppear {
                if !firstTime {
                    weatherViewModel.requestLocation()
                    firstTime = true
                    
                        }
                    }
            }
            
            
    }
    
    func actualizarDatos() async {
        await Task.sleep(1000000000)
        weatherViewModel.requestLocation()
    }
    
}

struct Clima_Previews: PreviewProvider {
    static var previews: some View {
        Clima()

    }
}
