
//  ManagingView.swift
//  host
//
//  Created by 고병학 on 2023/06/10.
//

import SwiftUI
import SwiftData

import DQCommon

struct ManagingView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \.value.index, order: .forward) var allQuestions: [QuestionModel]
    
    @State private var selectedSegment: Int = QuestionType.TYPE_SELECT.rawValue
    @State private var selectedQuestionType: QuestionType = .TYPE_SELECT
    
    private let segmentItems: [String] = QuestionType.allCases.map { $0.stringValue }
    
    @State private var selectedItems: [CodableQuestionModel] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 0)
                Picker(
                    selection: $selectedSegment,
                    label: Text("Segmented Control")
                ) {
                    ForEach(0..<QuestionType.allCases.count) { index in
                        Text(segmentItems[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .onChange(of: selectedSegment) { oldValue, newValue in
                    guard oldValue != newValue,
                          let type: QuestionType = .init(rawValue: newValue) else {
                        return
                    }
                    selectedQuestionType = type
                    selectedItems = allQuestions
                        .map { $0.value }
                        .filter { $0.question_type == selectedSegment }
                }
                
                Spacer()
                
                List(
                    selectedItems,
                    id: \.self
                ) { item in
                    QuizCardView(
                        question: "\(item.question)",
                        questionChoices: "\(item.question_choices)",
                        answer: "\(item.answer)"
                    )
                }
            }
            .navigationTitle("관리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink(
                    destination: AddQuizView()
                        .modelContainer(for: [
                            QuestionModel.self
                        ]),
                    label: {
                        Text("퀴즈 추가")
                    })
            }
            .onAppear(perform: {
                print("🟢 on appear")
                print("\(allQuestions.map({$0.value.question}))")
                self.selectedItems = allQuestions
                    .map { $0.value }
                    .filter { $0.question_type == selectedSegment }
                
//                let tempValue: [QuestionModel] = ["""
//                WWDC 2023에서 Swift 새롭게 나온 기능에 대한 설명입니다. 소스 코드를 컴파일할 때 변환하므로 반복적인 코드를 직접 작성하지 않도록 만들어 주는 기능은 무엇일까요?
//                
//                1. TipKit 2. Swift Data 3. Macros 4. Protocol 5. async/await
//                """,
//                                              
//                """
//                2023 KWDC 행사 날짜는?
//                
//                1. 2023년 7월 1일 2. 2023년 7월 16일 3. 2023년 7월 18일 4.2023년 7월 21일 5. 2023년 7월 30일
//                """,
//                                              
//                """
//                Macros는 어떤 접근제어 수준을 가져야 하나요?
//                
//                1. internal 2. open 3. open 4. public 5.private
//                """,
//                                              
//                                              
//                """
//                네트워크 계층의 데이터 링크 계층의 단위는 무엇인가요?
//                
//                1. 패킷 2. 프레임 3. 비트
//                """,
//                                              
//                """
//                오늘 행사의 운영진 중 ya로 시작하는 분의 이름은?
//                
//                1.yagom 2. yahae 3. yajonjar
//                """,
//                                              
//                """
//                오늘의 힘이 되어 줄 에너지 드링크의 이름은?
//                
//                1.Hotsixx 2. Hot6 3. HotHot 4. yagom
//                """,
//                                              
//                """
//                오늘 출제자가 먹은 밥은?
//                
//                1.빅치킨마요 2. 스팸 김치마요
//                """,
//                """
//                Swift 언어는 어떤 회사에서 개발되었을까요?
//                
//                a) Apple
//                b) Google
//                c) Microsoft
//                d) Facebook
//                e) Amazon
//                """,
//                                              
//                """
//                Swift에서 사용되는 데이터 타입 중, 정수형을 표현하는 타입은 무엇일까요?
//                
//                a) Int
//                b) Float
//                c) String
//                d) Bool
//                e) Array
//                """,
//                                              
//                """
//                Swift에서 함수의 반환 값을 지정할 때 사용하는 키워드는 무엇일까요?
//                
//                a) var
//                b) let
//                c) return
//                d) func
//                e) class
//                """,
//                                              
//                """
//                Swift에서 다른 타입으로의 변환을 위해 사용되는 키워드는 무엇일까요?
//                
//                a) convert
//                b) cast
//                c) switch
//                d) try
//                e) import
//                """,
//                                              
//                """
//                Swift에서 강제 옵셔널(Optional) 타입을 나타내기 위해 사용되는 기호는 무엇일까요?
//                
//                a) !
//                b) ?
//                c) *
//                d) &
//                e) #
//                """
//                ].enumerated().map {
//                    return QuestionModel(value: CodableQuestionModel(
//                        index: $0,
//                        question_id: UUID().uuidString,
//                        question: $1.components(separatedBy: "?")[0],
//                        question_choices: $1.components(separatedBy: "?").last?.trimmingCharacters(in: .newlines) ?? "",
//                        answer: "\(([1,2,3,4].randomElement() ?? 5))",
//                        response: true,
//                        question_type: 0
//                    ))
//                }
            })
        }
    }
}


#Preview {
    ManagingView()
        .modelContainer(for: [
            QuestionModel.self
        ])
}
