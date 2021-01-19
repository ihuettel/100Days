//
//  ContentView.swift
//  Animations
//
//  Created by Ian Huettel on 1/15/21.
//
//  There's a lot of *waves arms around* stuff here.
//  It's all been useful in some way of helping me learn animations more.
//  I'll be honest, animations are not my strong suit, so this was an
//  adventure, however it's been fun.
//
//  Currently, I have an issue where the draggable card, which I decided
//  to make disappear and reappear using the second Tap Me! button doesn't
//  animate on when it appears but does when it disappears. I can make it
//  do the inverse, but making it do both is giving me some trouble.
//  I have some ideas as to what could be causing it, but as it stands,
//  I would want to tinker around with it more, and I don't have the time
//  at this moment! (So, it will stay as is until I revisit this project.)
//
//  At the end of the day, this is a technique project, and therefore is
//  more of a playground than an app with any level of polish.
//
//  Also, the snake is cool and fun.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: 90, anchor: .topTrailing),
            identity: CornerRotateModifier(amount: 0, anchor: .topTrailing)
        )
    }
}

struct ContentView: View {
    @State private var buttonScaleBy: CGFloat = 1
    @State private var animationAmount: CGFloat = 1
    @State private var secondAnimation = 0.0
    
    @State private var cardDrag = CGSize.zero
    @State private var showingCard = false
    
    @State private var textDrag = CGSize.zero
    @State private var colorChange = false
    
    let letters = Array("I'm a snake!")
    
    var body: some View {
        print(animationAmount)
        
        return VStack {
            Stepper("Adjust Button", value: $animationAmount.animation(), in: 1...4, step: 0.25)
            
            Spacer()
            Button("Tap me!") {
                animationAmount += 0.25
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
            Spacer()
            
            
            if showingCard {
                LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 200, height: 135)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        Text("SwiftUI")
                            .offset(x: -10.0, y: -10.0)
                            .foregroundColor(.white)
                            .font(.headline),
                        alignment: .bottomTrailing
                    )
                    .offset(cardDrag)
                    .gesture(DragGesture()
                                .onChanged { self.cardDrag = $0.translation }
                                .onEnded { _ in
                                    withAnimation {
                                        self.cardDrag = .zero
                                    }
                                }
                    )
//                    .animation(.spring()) // This animates the whole gesture instead of just the onEnded animation
                    
                    .transition(.pivot)
                Spacer()
            }
            
            Button("Tap me!") {
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.showingCard.toggle()
                    self.secondAnimation += 360
                }
            }
            .padding(50)
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.green)
                    .scaleEffect(buttonScaleBy)
                    .opacity(Double(2 - buttonScaleBy))
                    .animation(
                        Animation.easeInOut(duration: 1)
                            .repeatForever(autoreverses: false)
                    )
            )
            .rotation3DEffect(
                .degrees(secondAnimation),
                axis: (x: 1, y: -1, z: 0))
            .onAppear {
                self.buttonScaleBy = 2
            }
            
            Spacer()
            
            HStack(spacing: 0) {
                ForEach(0 ..< letters.count) { num in
                    Text(String(self.letters[num]))
                        .padding(5)
                        .font(.headline)
                        .background(colorChange ? Color.orange : Color.purple)
                        .offset(textDrag)
                        .animation(Animation.default.delay(Double(num) / 10))
                        .gesture(DragGesture()
                                    .onChanged {
                                        textDrag = $0.translation
                                    }
                                    .onEnded { _ in
                                        textDrag = .zero
                                        colorChange.toggle()
                                    }
                        )
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
