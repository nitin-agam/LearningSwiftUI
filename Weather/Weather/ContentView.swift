//
//  ContentView.swift
//  Weather
//
//  Created by Nitin Aggarwal on 30/09/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            WeatherBackgroundView(topColor: .blue, bottomColor: Color("lightBlue"))
            VStack {
                CityNameView(cityName: "New Delhi, India")
                CurrentWeatherStatusView(imageName: "cloud.sun.fill", temperature: 76)
                
                HStack(spacing: 20) {
                    WeatherDayView(dayName: "TUE", imageName: "sun.max.fill", temperature: 60)
                    WeatherDayView(dayName: "WED", imageName: "cloud.sun.fill", temperature: 70)
                    WeatherDayView(dayName: "THU", imageName: "cloud.sun.rain.fill", temperature: 62)
                    WeatherDayView(dayName: "FRI", imageName: "cloud.rainbow.half", temperature: 40)
                    WeatherDayView(dayName: "SAT", imageName: "snowflake", temperature: 26)
                }
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    WeatherButtonView(title: "Change Time of Day",
                                      textColor: .blue,
                                      backgroundColor: .white)
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
    
    let dayName: String
    let imageName: String
    let temperature: Int
    
    var body: some View {
        VStack(spacing: 12) {
            Text(dayName)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(.white)
        }
    }
}

struct WeatherBackgroundView: View {
    
    let topColor: Color
    let bottomColor: Color
    
    var body: some View {
        LinearGradient(colors: [topColor, bottomColor],
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
            .background(backgroundColor)
            .font(.system(size: 20, weight: .semibold))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
