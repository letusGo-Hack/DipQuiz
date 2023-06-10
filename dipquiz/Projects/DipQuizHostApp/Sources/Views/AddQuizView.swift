//
//  AddQuizView.swift
//  DipQuizHost
//
//  Created by 고병학 on 2023/06/10.
//  Copyright © 2023 kr.byunghak. All rights reserved.
//

import SwiftUI

import DQCommon

struct AddQuizView: View {
    @State private var selectedSegment: Int = QuestionType.TYPE_SELECT.rawValue
    @State private var selectedQuizType: QuestionType = .TYPE_SELECT
    @State private var quizContent: String = ""
    @State private var answer: String = ""
    @State private var isOSelected: Bool = false
    @State private var isXSelected: Bool = false
    
    private let quizTypeCount: Int = QuestionType.allCases.count
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Picker(
                    selection: $selectedSegment,
                    label: Text("Segmented Control")
                ) {
                    ForEach(0..<quizTypeCount) { index in
                        Text(QuestionType.allCases[index].stringValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .onChange(of: selectedSegment) { oldValue, newValue in
                    guard oldValue != newValue,
                          let type: QuestionType = .init(rawValue: newValue) else {
                        return
                    }
                    quizContent = ""
                    answer = ""
                    selectedQuizType = type
                }
                
                Group {
                    Text("문제를 입력해주세요")
                        .font(.title3)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    TextEditor(text: $quizContent)
                        .frame(height: 300)
                        .cornerRadius(8)
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                switch selectedQuizType {
                case .TYPE_SELECT:
                    Group {
                        Text("정답")
                        Spacer().frame(height: 10)
                        TextField("정답을 입력해주세요", text: $answer)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .textFieldStyle(.roundedBorder)
                    }
                    .textFieldStyle(.roundedBorder)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                case .TYPE_OX:
                    Group {
                        Text("보기")
                        HStack {
                            ZStack(alignment: .center) {
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(isOSelected ? .blue : .clear)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.blue, lineWidth: 2)
                                    )
                                
                                Text("O")
                                    .font(.title)
                                    .foregroundColor(isOSelected ? .white : .blue)
                            }
                            .onTapGesture {
                                isOSelected.toggle()
                                isXSelected = false
                            }
                            
                            ZStack(alignment: .center) {
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(isXSelected ? .red : .clear)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.red, lineWidth: 2)
                                    )
                                Text("X")
                                    .font(.title)
                                    .foregroundColor(isXSelected ? .white : .red)
                            }
                            .onTapGesture {
                                isXSelected.toggle()
                                isOSelected = false
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
                
                Spacer()
                
                Button {
                    print("제출하기")
                } label: {
                    Text("제출하기")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(Color.black)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(BorderedButtonStyle())
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
            }
            .background(Color(uiColor: .secondarySystemBackground))
            .navigationTitle("문제 추가")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddQuizView()
}
