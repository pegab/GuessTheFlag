//
//  ContentView.swift
//  Project2
//
//  Created by Peter Gabriel on 20.12.25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland",
                     "Spain", "UK", "Ukraine", "US"].shuffled() // .shuffeld, damit das Array auch random ist.
    @State private var correctAnswer = Int.random(in: 0...2) //Wählt zufällig eines der ersten 3 Elemente des Arrays aus.
    
    @State private var showingScore = false //property to show the alert on demand
    @State private var scoreTitle = "" //Message für den Alert
    
    
    var body: some View {
        
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    /*
                     In der Schleife wird der closure-based Button initializaer verwendet.
                     >Die erste closure ist die action closure -> what happens if the button is pressend
                     >Die zweite closure ist die label closure -> what it looks like
                     */
                    
                    
                    /*Macht 3 Buttons mit den ersten 3 Elementen des Arrays
                     Button 0
                     Button 1
                     Button 2
                     */
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: ???")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        //Alert Modifier -> Alert gets shown when showingScore Boolean is true
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your Score is ???")
        }
        
    }
    
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        //das triggert den Alert Modifier
        showingScore = true
    }
    
    
    //Diese func setzt das Array sowie die correctAnswer für einen neue Runde zurück
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

#Preview {
    ContentView()
}
