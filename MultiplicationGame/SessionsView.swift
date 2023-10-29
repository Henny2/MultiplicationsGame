//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Henrieke Baunack on 10/28/23.
//

import SwiftUI

struct GameView: View {
    @Binding var gameIsActive : Bool
    @Binding var testString : String
    var body: some View {
        NavigationStack{
            VStack{
                Text("Showing some multiplication!")
            }
            .navigationTitle("MultiFly")
            .toolbar{
                Button("Restart Game"){
                    gameIsActive = false
                }
            }
        }
    }
}

struct AppContentView: View {
    @State var gameIsActice = false
    @State var testString = "Hello"
    var body: some View {
        return Group{
            if gameIsActice {
                GameView(gameIsActive: $gameIsActice, testString: $testString)
            }
            else {
                SessionsView(gameIsActive: $gameIsActice)
            }
        }
    }
}

struct SessionsView: View {
    @State var selectedMultiplication = 1
    @State var numQuestions = 5
//    @State private var selectedMultiplication = 0
//    @State private var numQuestions = 5
//    @Binding var selectedMultiplication : Int
//    @Binding var numQuestions : Int
    @Binding var gameIsActive : Bool
    let numQuestionsOptions = [5, 10, 15]
    var body: some View {
        NavigationStack{
            Form{
                Section("What multiplication do you want to be tested on?") {
                    HStack{
                        Spacer()
                        Picker("Multiplication Table", selection: $selectedMultiplication) {
                            ForEach(1..<13) { num in
                                Text("\(String(num))")
                            }
                        }
                        .labelsHidden()
                        //.onReceive([self.selectedMultiplication].publisher.first()) { value in
                        //    print("value has changed")
                        //}
                        Spacer()
                    }
                }
                Section("How many questions do you want?"){
                    Picker("Number of questions Picker", selection: $numQuestions){
                        ForEach(numQuestionsOptions, id:\.self){ option in
                            Text("\(option)")
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.segmented)
                }
                Section("Ready to start the game?"){
                    HStack{
                        Spacer()
                        Button("Yes"){
                            print("reeeeady")
                            gameIsActive = true
                        }
                        Spacer()
                    }
                }
            }.navigationTitle("MultiFly")
        }
        
    }
}

#Preview {
    AppContentView()
}
