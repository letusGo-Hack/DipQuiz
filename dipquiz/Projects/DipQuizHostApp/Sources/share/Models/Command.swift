import UIKit

//통신 종류
enum CommandType: Decodable, Encodable {
    case NONE
    case INT
    case INT_REQUEST
    case SCORE
    case SCORE_WAIT
    case SCORE_REQUEST
    case STATUS
    case STATUS_REQUEST
}

struct Command: Identifiable, Equatable, Codable {
  var id = UUID() //접속 성공시 발생되는 ID
  let displayName: String
  let body: String
  var time = Date()
    
    var question_id: String
    var question: String
    var answer: String
    var value: String
    var type: CommandType

  var isUser: Bool {
    return displayName == UIDevice.current.name
  }
}
