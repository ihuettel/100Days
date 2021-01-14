//
//  ContentView.swift
//  Roshambo
//
//  Created by ihuettel on 1/13/21.
//
//  Finished this pretty late in the evening.
//  I really would like to tune this a little more
//  and make the code a little bit cleaner.
//  I've got a lot of extra bits that could be simplied
//  like extra modifiers and not-amazing logic,
//  but it's a bit past 3AM so.. that's for another day.
//
//  I also built this project with tests!..
//  ..which I still need to implement.
//
//  Another day.
//

import SwiftUI

struct StyledButton: View {
    var title: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .font(.title3)
            .foregroundColor(.black)
            .frame(width: 100, height: 100, alignment: .center)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
    }
}

struct ContentView: View {
    @State private var currentMove = Int.random(in: 0 ... 2)
    @State private var shouldWin = Bool.random()
    @State private var showingAnswer = false
    @State private var alertTitle = ""
    @State private var score = 0
    @State private var questionsAnswered = 0
    
    var correctMove: String {
        if shouldWin && currentMove == 2 {
            return "Rock"
        } else if !shouldWin && currentMove == 0 {
            return "Scissors"
        } else {
            return moves[shouldWin ? currentMove + 1 : currentMove - 1]
        }
    }
    
    let moves = ["Rock", "Paper", "Scissors"]
    
    func isCorrect(for answer: String) {
        if answer == correctMove {
            alertTitle = "Correct!"
            score += 1
        } else {
            alertTitle = "Not quite.."
            score -= 1
        }
        questionsAnswered += 1
        showingAnswer = true
    }
    
    func newRound() {
        currentMove = Int.random(in: 0 ... 2)
        shouldWin = Bool.random()
        if questionsAnswered > 9 {
            questionsAnswered = 0
            score = 0
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Color(white: 0.85)
                    .frame(height: 100)
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
                    
                Spacer()
                Color(white: 0.85).frame(height: 245)
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 15) {
                VStack {
                    Text("Rock Paper Scissors")
                    Text("Brain Challenge")
                }
                .font(.title)
                Spacer()
                VStack(spacing: 15) {
                    Text("You must \(shouldWin ? "win" : "lose").")
                    Text("Your opponent chooses..")
                    Text(moves[currentMove])
                        .fontWeight(.bold)
                        .font(.title)
                        .frame(width: 150, height: 50)
                        .background(Color(white: 0.85))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1))
                }
                
                Spacer()
                
                Text("Correct Answers: \(score) | Total Answers: \(questionsAnswered)")
                    .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(spacing: 15) {
                    StyledButton(title: "Rock", color: .red) {
                        isCorrect(for: "Rock")
                    }
                    
                    HStack(spacing: 15) {
                        StyledButton(title: "Paper", color: .yellow) {
                            isCorrect(for: "Paper")
                        }
                        StyledButton(title: "Scissors", color: .blue) {
                            isCorrect(for: "Scissors")
                        }
                    }
                }
                Color.clear.frame(height: 1)
            }
        }
        .alert(isPresented: $showingAnswer) {
            Alert(title: Text(alertTitle), message: Text("The answer was \(correctMove)."), dismissButton: .default(Text("Continue")) {
                self.newRound()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
