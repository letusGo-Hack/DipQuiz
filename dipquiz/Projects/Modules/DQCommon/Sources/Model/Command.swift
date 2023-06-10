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
    public var type: CommandType

  var isUser: Bool {
    return displayName == UIDevice.current.name
  }
}
