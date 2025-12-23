//
//  ContentView.swift
//  Project2
//
//  Created by Peter Gabriel on 20.12.25.
//

import SwiftUI

struct ContentView: View {
    //muss static sein, damit es outside of the instance gespeichert wird, ansonsten würde eine property eine andere lokale prop lesen wollen und das ist nicht erlaubt.
   static let countriesNew = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland","Spain", "UK", "Ukraine", "US"]
    
    @State private var countries = countriesNew.shuffled() // .shuffeld, damit das Array auch random ist.
    @State private var correctAnswer = Int.random(in: 0...2) //Wählt zufällig eines der ersten 3 Elemente des Arrays aus.
    
    @State private var showingScore = false //property to show the alert on demand
    @State private var endOfGame = false //property to show the end of game alert
    @State private var scoreTitle = "" //Message für den Alert score
    @State private var endOfGameTitle = "END OF GAME" //Message für den endofgame Alert
    @State private var score = 0
    
    @State private var wrongFlag: Int = 0
    @State private var removeFlag: Int = 0
    @State private var maxQuestions: Int = 0
    
    
    var body: some View {
        
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                
                Spacer()
                
                
                HStack{
                    
                    
                    VStack {
                        Text("\(maxQuestions) / 8 Versuche")
                    }    .frame(maxWidth: .infinity)
                        //.padding(.vertical, 10)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 20))
                    
                    
                    
                    VStack {
                        
                        if score == 8 {
                            Text("⭐️⭐️⭐️")
                            
                        } else if score >= 5 {
                            Text ("⭐️⭐️")
                        } else if score >= 3 {
                            Text ("⭐️")
                        }
                    }    .frame(maxWidth: .infinity)
                        //.padding(.vertical, 10)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 20))
                    
                }
            
             
                Spacer()
               
                VStack(spacing: 20){
                    VStack {
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    /*
                     In der Schleife wird der closure-based Button initializer verwendet.
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
                            wrongFlag = number
                            maxQuestions += 1
                        } label: {
                            Image(countries[number])
                                .clipShape(.rect)
                                .shadow(radius: 5)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                VStack {
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                   
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
            }
            .padding()
        }
        //Alert Modifier -> Alert gets shown when showingScore Boolean is true
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion) //Sobald der Butten gedrückt wird, wird showingScore wieder false
        } message: {
            let theFlags = ["UK", "US"]
            
            if theFlags.contains(countries[wrongFlag]) {
                Text("That is the flag of the \(countries[wrongFlag])")
            } else {
                
                Text("That is the flag of \(countries[wrongFlag])")}
        }
        .alert(endOfGameTitle, isPresented: $endOfGame) {
            Button("New Game", action: restartGame)
        } message: {
            Text("You ve managed a score of \(score)")
        }
        
    }
    
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            removeFlag = number
            
        } else {
            scoreTitle = "Wrong"
            score -= 1
        }
        
        
        
        //das triggert den EndofGame Alert
        if maxQuestions == 7 {
            endOfGame = true
        } else {
            showingScore = true   //das triggert den Alert Modifier (score)
        }
    }
    
    
    //Diese func setzt das Array sowie die correctAnswer für einen neue Runde zurück
    
    func askQuestion() {
        countries.remove(at: removeFlag)
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    
    //Diese func setzt alles für ein New Game zurück
    func restartGame(){
        countries = Self.countriesNew //muss mit Self. auferufen werden da es eine static prop ist
        score = 0
        maxQuestions = 0
        
    }
   
    
}

#Preview {
    ContentView()
}
