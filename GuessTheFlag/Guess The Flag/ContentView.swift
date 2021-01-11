//
//  ContentView.swift
//  Guess The Flag
//
//  Created by homebase on 1/10/21.
//

import SwiftUI

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
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    Text("Total correct answers: \(score)")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Longest Streak: \(longestStreak)")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Current Streak: \(streak)")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
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
