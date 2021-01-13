//
//  ContentView.swift
//  Guess The Flag
//
//  Created by ihuettel on 1/10/21.
//
//  It is my intention to come back and add additional code comments to this project
//  and potentially build some testing into this app.
//  This all relies on me finding the time to do such things.
//

import SwiftUI

struct ScoreText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.title2)
            .fontWeight(.bold)
    }
}

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var streak = 0
    @State private var longestStreak = 0
    
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [.white, .white, .white, .gray, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.4)
            
            VStack(spacing: 30) {
                VStack {
                    ScoreText(text: "Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(country: self.countries[number])
                    }
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    ScoreText(text: "Total correct answers: \(score)")
                    ScoreText(text: "Longest Streak: \(longestStreak)")
                    ScoreText(text: "Current Streak: \(streak)")
                }
                
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text("Your score is \(score)."), dismissButton: .default(Text("Continue")) { self.askQuestion()
                  })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
            streak += 1
            if longestStreak < streak {
                longestStreak = streak
            }
        } else {
            scoreTitle = """
            Try again.
            That was the flag of \(countries[number]).
            """
            streak = 0
        }
        showingScore = true
    }
        
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
