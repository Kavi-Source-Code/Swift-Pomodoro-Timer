//
//  ContentView.swift
//  Pomodoro Timer
//
//  Created by Kavi Van Auken on 1/17/26.
//

import SwiftUI
internal import Combine

/* This is a timer app.
 Features include buttons, shortcuts and even nice looks and stylish fonts!!
 */


enum TimerState {
    case work
    case shortBreak
    case longBreak
    case timesUp
}


struct ContentView: View {
    @State private var secs = 0
    @State private var mins = 0
    @State private var hrs = 0
    @State private var running = false
    @State private var buttonText = "Start"
    @State private var collectingHours = false
    @State private var collectingMins = false
    @State private var collectingSecs = false
    @State private var timeStr = ""
    @State private var state: TimerState!
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let timerBackgroundColor = Color(red: 0.815, green: 0.968, blue: 0.365)
    
    let rectColor = Color(red: 29 / 255.0, green: 162 / 255.0, blue: 216 / 255.0)

    var body: some View {
        let combinedHrsMinsSecs = String(format: "%02d:%02d:%02d", hrs, mins, secs)
        
        Text("TIMER")
            .foregroundColor(rectColor)
            .font(Font.custom("progresspixel-bold", size: 60))
            .padding(.bottom, 40)
        
        VStack {
            
            Text("\(combinedHrsMinsSecs)").padding(20)
                .foregroundColor(Color(red: 29 / 255.0, green: 36 / 255.0, blue: 21 / 255.0))
                .font(Font.custom("monogram", size: 40))
                .background(timerBackgroundColor).onReceive(timer) { _ in
                    if (hrs != 0 || mins != 0 || secs != 0) && running {
                        
                        // Decrementing logic
                        
                        if secs == 0 && mins != 0 {
                            mins = mins - 1
                            secs = 59
                        } else if hrs != 0 && mins == 0 {
                            hrs = hrs - 1
                            mins = 59
                            secs = 59
                        } else {
                            secs = secs - 1
                        }
                    }
                    
                }
            Button(buttonText) {
                running = !running
                if running {
                    buttonText = "Stop"
                } else {
                    buttonText = "Start"
                }
            }
            .font(Font.custom("monogram", size: 40))
            .foregroundColor(Color(red: 0.012, green: 0.412, blue: 0.614))
            .keyboardShortcut("s", modifiers: .shift)
            
            Button("Set Hours") {
                collectingHours = true
                timeStr = ""
            }
            .alert("Enter hours", isPresented: $collectingHours) {
                TextField("Hours", text: $timeStr)
                Button("Ok") {
                    if let x = Int(timeStr) {
                        if x <= 99 && x >= 0 {
                            hrs = x
                        }
                    }
                    // hrs = Int(timeStr) ?? 0
                }
            } message: {
                Text("Enter hours")
            }
            .font(Font.custom("monogram", size: 40))
            .foregroundColor(Color(red: 0.012, green: 0.412, blue: 0.614))
            
            Button("Set Mins") {
                collectingMins = true
                timeStr = ""
            }
            .alert("Enter mins", isPresented: $collectingMins) {
                TextField("Mins", text: $timeStr)
                Button("Ok") {
                    if let x = Int(timeStr) {
                        if x <= 59 && x >= 0 {
                            mins = x
                        }
                    }
                    // mins = Int(timeStr) ?? 0
                }
            } message: {
                Text("Enter mins")
            }
            .font(Font.custom("monogram", size: 40))
            .foregroundColor(Color(red: 0.012, green: 0.412, blue: 0.614))
            
            Button("Set Secs") {
                collectingSecs = true
                timeStr = ""
            }
            .alert("Enter Secs", isPresented: $collectingSecs) {
                TextField("Secs", text: $timeStr)
                Button("Ok") {
                    if let x = Int(timeStr) {
                        if x <= 59 && x >= 0 {
                            secs = x
                        }
                    }
                    // mins = Int(timeStr) ?? 0
                }
            } message: {
                Text("Enter secs")
            }
            .font(Font.custom("monogram", size: 40))
            .foregroundColor(Color(red: 0.012, green: 0.412, blue: 0.614))
        }
        .padding(25)
        .border(rectColor, width: 8)
        .cornerRadius(20)
    }
}

#Preview {
    ContentView()
}
