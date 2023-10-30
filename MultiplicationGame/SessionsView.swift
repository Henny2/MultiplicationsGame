//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Henrieke Baunack on 10/28/23.
//

import SwiftUI
import Observation

@Observable
class ViewModel {
    init() {}
    
    var gameIsActive = false
    var numQuestions = 5
    var selectedMultiplication = 0
    var questions : Array<Question> = []
}

struct Question {
    var questionText : String
    var answer : Int
}

struct AppContentView: View {
    var viewModel = ViewModel()
    var body: some View {
        return Group{
            if viewModel.gameIsActive {
                GameView(viewModel: viewModel)
            }
            else {
                SessionsView(viewModel: viewModel)
            }
        }
    }
}

struct GameView: View {
    @Bindable var viewModel: ViewModel
    @State var questionNumber = 0
    @State var userAnswer = 0
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Text(viewModel.questions[questionNumber].questionText).font(.title)
                Spacer()
                HStack() {
                    TextField("Answer", value: $userAnswer, format: .number).multilineTextAlignment(.center).font(.title)
                }
                Spacer()
                Spacer()
                Spacer()
            }
            .navigationTitle("MultiFly")
            .toolbar{
                Button("Restart Game"){
                    viewModel.gameIsActive = false
                }
            }
        }
    }
}

struct SessionsView: View {
    @Bindable var viewModel: ViewModel
    let numQuestionsOptions = [5, 10, 15]
    var body: some View {
        NavigationStack{
            Form{
                Section("What multiplication do you want to be tested on?") {
                    HStack{
                        Spacer()
                        Picker("Multiplication Table", selection: $viewModel.selectedMultiplication) {
                            ForEach(1..<13) { num in
                                Text("\(String(num))")
                            }
                        }
                        .labelsHidden()
                        Spacer()
                    }
                }
                Section("How many questions do you want?"){
                    Picker("Number of questions Picker", selection: $viewModel.numQuestions){
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
                            startGame()
                            viewModel.gameIsActive = true
                        }
                        Spacer()
                    }
                }
            }.navigationTitle("MultiFly")
        }
    }
    func startGame() {
        // create questions, add them to array
        viewModel.questions = []
        for i in 1...viewModel.numQuestions {
            print("HI \(i)")
            // create a question
            // pick a random multiplicator
            let selectedMultiplicator = viewModel.selectedMultiplication + 1
            let multiplicator = Int.random(in: 1..<13)
            let questionText = "What is \(selectedMultiplicator) * \(multiplicator)?"
            let answer = selectedMultiplicator * multiplicator
            print(questionText)
            print(answer)
            let question = Question(questionText: questionText, answer: answer)
            viewModel.questions.append(question)
        }
        print(viewModel.questions)
    }
}

#Preview {
    AppContentView()
}
