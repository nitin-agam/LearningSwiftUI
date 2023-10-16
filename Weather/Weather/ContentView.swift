//
//  ContentView.swift
//  Weather
//
//  Created by Nitin Aggarwal on 30/09/23.
//

import SwiftUI

struct WeatherDay {
    
    let name: String
    let image: String
    let temp: Int
    
    static func dummyData() -> [Self] {
        return [
            WeatherDay(name: "TUE", image: "sun.max.fill", temp: 75),
            WeatherDay(name: "WED", image: "cloud.sun.fill", temp: 68),
            WeatherDay(name: "THU", image: "cloud.sun.rain.fill", temp: 62),
            WeatherDay(name: "FRI", image: "cloud.rainbow.half", temp: 65),
            WeatherDay(name: "SAT", image: "snowflake", temp: 26)
        ]
    }
}

struct ContentView: View {
    
    @State private var isNight = false
    private let weatherDays: [WeatherDay] = WeatherDay.dummyData()
    
    var body: some View {
        ZStack {
            WeatherBackgroundView(isNight: $isNight)
            VStack {
                CityNameView(cityName: "New Delhi, India")
                CurrentWeatherStatusView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: 76)
                
                HStack(spacing: 20) {
                    ForEach(weatherDays, id: \.name) { day in
                        WeatherDayView(weatherDay: day)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    isNight.toggle()
                }, label: {
                    WeatherButtonView(title: "Change Time of Day",
                                      textColor: .white,
                                      backgroundColor: isNight ? .black : .blue)
                })
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    
    let weatherDay: WeatherDay
    
    var body: some View {
        VStack(spacing: 12) {
            Text(weatherDay.name)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)
            
            Image(systemName: weatherDay.image)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(weatherDay.temp)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(.white)
        }
    }
}

struct WeatherBackgroundView: View {
    
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(colors: [isNight ? .black : .blue,
                                isNight ? .gray : Color("lightBlue")],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea(edges: .all)
    }
}

struct CityNameView: View {
    
    let cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium))
            .foregroundStyle(.white)
            .padding()
    }
}

struct CurrentWeatherStatusView: View {
    
    let imageName: String
    let temperature: Int
    
    var body: some View {
        VStack(spacing: 10) {
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundStyle(.white)
        }
        .padding(.bottom, 40)
    }
}

struct WeatherButtonView: View {
    
    let title: String
    let textColor: Color
    let backgroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .foregroundStyle(textColor)
            .background(backgroundColor.gradient)
            .font(.system(size: 20, weight: .semibold))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
