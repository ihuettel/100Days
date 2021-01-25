//
//  ContentView.swift
//  ProductFarms
//
//  Created by Ian Huettel on 1/19/21.
//

import SwiftUI

func threeChoices(for num1: Int, times num2: Int) -> [Int] {
    let answer = num1 * num2
    let fake1: Int
    let fake2: Int
    
    switch Int.random(in: 0 ..< 5 ) {
    case 0:
        fake1 = answer + num2
    case 1:
        fake1 = answer + num1
    case 2:
        fake1 = answer - (num2 / 2)
    case 3:
        fake1 = answer - (num1 / 2)
    default:
        fake1 = answer - 1
    }
    
    switch Int.random(in: 0 ..< 5) {
    case 0:
        fake2 = answer - num2
    case 1:
        fake2 = answer - num1
    case 2:
        fake2 = answer + (num2 / 2)
    case 3:
        fake2 = answer + (num1 / 2)
    default:
        fake2 = answer + 1
    }
    
    return [answer, fake1, fake2].shuffled()
}

func nextRound() -> Void {
    // Move to next round
}

func newGame(difficulty: Int, rounds: Int?) -> Set<Array<Int>> {
    var problems = Set<Array<Int>>()
    for num1 in 2 ... difficulty {
        for num2 in 1 ... 12 {
            problems.insert([num1, num2])
        }
    }
    return problems
}

func getMaxRounds(for difficulty: Int) -> Int {
    return (difficulty - 1) * 12
}

//  [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
//  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

struct ContentView: View {
    @State private var difficulty = 3
    @State private var groupSize = 0
    @State private var showingOptions = true
    @State private var answer = 0
    
    @State private var currentRound: Int = 0
    @State private var lastRound: Int = 5
    @State private var allQuestions = Set<Array<Int>>()
    @State private var currentQuestion = [2, 2]
    
    @State private var score = 0
    
    private var distractors = [0]
    private let groups = [5, 10, 20, nil]
    private var groupText: String {
        guard let num = groups[groupSize] else {
            return "All"
        }
        return "\(num)"
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    Text("Score: \(score)")
                    
                    Text("\(currentQuestion[0]) x \(currentQuestion[1]) = ?")
                        .font(.title)
                        .fontWeight(.black)
                        .padding(25)
                    
                    HStack {
                        ForEach(threeChoices(for: difficulty, times: groups[groupSize] ?? getMaxRounds(for: 3)), id: \.self) { option in
                            Button("\(option)") {
                                if option == currentQuestion[0] * currentQuestion[1] {
                                    score += 1
                                } else {
                                    // Do something else
                                }
                                
                                if allQuestions.isEmpty {
                                    // Do something
                                } else {
                                    currentQuestion = allQuestions.removeFirst()
                                }
                            }
                            .font(.subheadline)
                            .padding(15)
                            .background(LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom))
                            .foregroundColor(.white)
                        }
                    }
                    .font(.subheadline)
                    .padding(15)
                    .background(LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom))
                    .foregroundColor(.white)
                    
                    Button("New game") {
                        allQuestions = newGame(difficulty: difficulty, rounds: groups[groupSize])
                        showingOptions.toggle()
                    }
                    .padding(50)
                    .background(LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottomTrailing))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    
                }
                
                VStack {
                    Spacer()
                    Stepper("Difficulty Level: \(difficulty)", value: $difficulty, in: 3 ... 12)
                    Stepper("Number of problems: \(groupText)", value: $groupSize, in: 0 ... 3)
                }
                .offset(x: showingOptions ? 0 : 1000)
                .navigationBarTitle("Banana")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
