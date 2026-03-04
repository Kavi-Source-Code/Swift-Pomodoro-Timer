//
//  ContentView.swift
//  Pomodoro Timer
//
//  Created by Kavi Van Auken on 1/17/26.
//

import SwiftUI
internal import Combine
import AVFoundation


/* This is a pomodoro timer app.
 Features include buttons, shortcuts and even nice looks and stylish fonts!!
 */


enum TimerState {
    case work
    case shortBreak
    case longBreak
    case timesUp
}


func playSound() {
    
}


struct ContentView: View {
    @State private var secs = 0
    @State private var mins = 0
    @State private var hrs = 0
    @State private var running = false
    @State private var collectingHours = false
    @State private var collectingMins = false
    @State private var collectingSecs = false
    @State private var timeStr = ""
    @State private var timerState: TimerState!
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let timerBackgroundColor = Color(red: 0.815, green: 0.968, blue: 0.365)
    
    let rectColor = Color(red: 29 / 255.0, green: 162 / 255.0, blue: 216 / 255.0)

    var body: some View {
        let combinedHrsMinsSecs = String(format: "%02d:%02d:%02d", hrs, mins, secs)
            
        Image(systemName: "timer")
            .font(.system(size: 40))
            .padding(30)
        Text("Pomodoro Timer")
            .foregroundColor(rectColor)
            .font(.system(size: 80))
            .padding(.bottom, 40)
        Text("If you have any suggestions/improvements, or a review, please do take some time... Also, you can [star this repo](https://github.com/Kavi-Source-Code/Swift-Pomodoro-Timer) and [leave a review](https://github.com/Kavi-Source-Code/Swift-Pomodoro-Timer/releases/tag/v1.0.0) if you find it useful. I am almost 9 and I like to code. This is a really big milestone for me!")
        VStack {
            Image(systemName: "arrowshape.up.fill")
                .font(.system(size: 32))
                .rotationEffect(Angle(degrees: Double(secs * 6)))
                .foregroundStyle(.yellow.opacity(0.5))
            Image(systemName: "arrowshape.up.fill")
                .font(.system(size: 32))
                .rotationEffect(Angle(degrees: Double(mins * 6)))
                .foregroundStyle(.red.opacity(0.5))
            Image(systemName: "arrowshape.up.fill")
                .font(.system(size: 32))
                .rotationEffect(Angle(degrees: Double(hrs * 6)))
                .foregroundStyle(.mint.opacity(0.5))
        }
        
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
                    
                    if (hrs == 0 && mins == 0 && secs == 0) && running {
                        // timer just finished; running should be false
                        running = false
                        //playSound()
                    }
                    
                }
            Button(running ? "Stop" : "Start") {
                running = !running
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
