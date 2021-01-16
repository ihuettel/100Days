//
//  ContentView.swift
//  WordScramble
//
//  Created by Ian Huettel on 1/15/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var rootWord = ""
    
    @State private var alertTitle = Text("")
    @State private var alertMessage = Text("")
    @State private var alertShowing = false
    
    @State private var currentScore = 0
    @State private var highScore = 0
    private var scoreText = """
        3- to 4-letter words: 1 point
        5- to 6-letter words: 2 points
        7-letter words: 4 points
        8-letter words: 7 points
    """
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a new word", text: $newWord, onCommit: checkWord)
                    .accessibilityIdentifier("wordEntry")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                
                Group {
                    Text("Current Score: \(currentScore)")
                        .accessibilityIdentifier("currentScore")
                        .padding(1)
                    Text("High Score: \(highScore)")
                        .accessibilityIdentifier("highScore")
                        .padding(1)
                    Button("Rules") {
                        alertTitle = Text("Points are earned as follows:")
                        alertMessage = Text(scoreText)
                        alertShowing = true
                    }
                    .padding(5)
                }
                .font(.headline)
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading: Button("Restart", action: newGame))
            .onAppear(perform: newGame)
        }
        .alert(isPresented: $alertShowing) {
            Alert(title: alertTitle, message: alertMessage, dismissButton: .default(Text("Continue")))
        }
    }
    
    
    
    func newGame() {
        if let startWordsFile = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsFile) {
                let allWords = startWords.components(separatedBy: .newlines)
                let oldWord = rootWord
                while oldWord == rootWord {
                    rootWord = allWords.randomElement() ?? "silkworm"
                }
                
                if currentScore > highScore {
                    highScore = currentScore
                }
                currentScore = 0
                usedWords = []
                return
            }
        }
        
        fatalError("Failed to load start.txt from Bundle")
    }
    
    
    
    func checkWord() {
        let newEntry = newWord
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !newEntry.isEmpty else {
            return
        }
        
        guard !usedWords.contains(newEntry) else {
            wordError(title: "Duplicate entry", message: "You've already used that word!")
            return
        }
        
        guard isEnglishWord(word: newEntry) else {
            wordError(title: "Not a valid word", message: "Only real words in the English language accepted!")
            return
        }
        
        guard usesValidLetters(word: newEntry) else {
            wordError(title: "Word not possible", message: "Your word contained unavailable letters!")
            return
        }
        
        
        //
        //  Now we have a switch to calculate how many points our player's words are worth.
        //  We also perform one last check in the form of our default parameter, which
        //  lets us make sure the player uses words at least 3 letters long.
        //
        //  Additionally, we should be able to safely ignore words longer than 8 letters,
        //  as those should have been filtered out in "usesValidLetters"
        //  Our "default" doesn't know that, but it also doesn't need to know that.
        //
        
        switch newEntry.count {
        case 3...4:
            currentScore += 1
        case 5...6:
            currentScore += 2
        case 7:
            currentScore += 4
        case 8:
            currentScore += 7
        default:
            wordError(title: "Too short", message: "Words must be at least 3 letters long!")
            return
        }
        
        usedWords.insert(newEntry, at: 0)
        newWord = ""
    }
    
    
    
    func usesValidLetters(word: String) -> Bool {
        let availableLetters = NSCountedSet(array: Array(rootWord))
        let potentialLetters = NSCountedSet(array: Array(word))
        
        for letter in potentialLetters {
            if potentialLetters.count(for: letter) > availableLetters.count(for: letter) {
                return false
            }
        }
        
        return true
    }
    
    
    
    func isEnglishWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return mispelledRange.location == NSNotFound
    }
    
    
    
    func wordError(title: String, message: String) {
        newWord = ""
        alertTitle = Text(title)
        alertMessage = Text(message)
        alertShowing = true
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
