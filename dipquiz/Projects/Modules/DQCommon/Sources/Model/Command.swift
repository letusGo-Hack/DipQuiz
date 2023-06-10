import UIKit

//통신 종류
public enum CommandType: Decodable, Encodable {
    case NONE
    case INT
    case INT_REQUEST
    case SCORE
    case SCORE_WAIT
    case SCORE_REQUEST
    case STATUS
    case STATUS_REQUEST
}

public struct Command: Identifiable, Equatable, Codable {
    public var id = UUID() //접속 성공시 발생되는 ID
    public let displayName: String
    public let body: String
    public var time = Date()
    
    public var question_id: String
    public var question: String
    public var answer: String
    public var value: String
    public var ranking: String = "-1"
    public var total_member: String = "0"
    public var type: CommandType
    
    init(id: UUID = UUID(), displayName: String, body: String, time: Date = Date(), question_id: String, question: String, answer: String, value: String, type: CommandType) {
        self.id = id
        self.displayName = displayName
        self.body = body
        self.time = time
        self.question_id = question_id
        self.question = question
        self.answer = answer
        self.value = value
        self.type = type
    }

  var isUser: Bool {
    return displayName == UIDevice.current.name
  }
}

public struct HostItem: Identifiable, Equatable, Codable {
    public var id = UUID()
    public var time = Date()
    public var question_id: String
}
