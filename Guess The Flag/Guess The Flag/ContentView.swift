//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Jan Sulejmani on 2/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var tappedFlag = ""
    @State private var roundCounter = 0
    @State private var newRoundBegins = false
    @State private var newRoundTitle = ""
    
    
    var body: some View {
        ZStack{
            RadialGradient(stops:[
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Correct"{
                Text("You scored a point!")
            }else{
                Text("That was wrong! This was the flag of \(tappedFlag).")
            }
            
        }
        
        .alert(newRoundTitle, isPresented: $newRoundBegins){
            Button("Play new round", action: askQuestion)
        } message:{
            Text("Your score for this round was \(userScore). Start a new round!")
            
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            userScore += 1
        } else{
            scoreTitle = "Wrong"
            tappedFlag = countries[number]
        }
        
        showingScore = true
        roundCounter += 1
        if roundCounter == 8{
            showingScore = false
            newRoundTitle = "New Round"
            newRoundBegins = true
            roundCounter = 0
        }
    }
    
    func askQuestion(){
        if newRoundBegins{
            userScore = 0
            newRoundBegins = false
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
