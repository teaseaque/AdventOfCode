import Foundation

let inputURL = Bundle.main.url(forResource: "input2", withExtension: "txt")
let input = try String(contentsOf: inputURL!, encoding: String.Encoding.utf8)

/// score = shape score + round outcome score
/// shape score = rock: 1, paper: 2, scissors: 3
/// outcome score = loss: 0, draw: 3, win: 6

let rounds = input.components(separatedBy: "\n")

let letterValues = ["AX", "BY", "CZ"]

let totalScore = rounds.reduce(0, { partialTotal, round in
  let letters = round.components(separatedBy: " ")
  let opLetter = letters.first!
  let myLetter = letters.last!
  
  guard !opLetter.isEmpty else { return partialTotal }

  let opScore = 1 + (letterValues.firstIndex(where: { $0.contains(opLetter) }) ?? 0)
  let myScore = 1 + (letterValues.firstIndex(where: { $0.contains(myLetter) }) ?? 0)

  let outcomeScore: Int
  switch myScore {
  case 3:
    outcomeScore = opScore == 1 ? 0 : opScore == myScore ? 3 : 6
  case 1:
    outcomeScore = opScore == 3 ? 6 : opScore == myScore ? 3 : 0
  default:
    outcomeScore = opScore > myScore ? 0 : opScore < myScore ? 6 : 3
  }
  
  return partialTotal + outcomeScore + myScore
})

// part 2

/// score = shape score + round outcome score
/// shape score = rock: 1, paper: 2, scissors: 3
/// outcomes: lose: X, draw: Y win: Z

let part2TotalScore = rounds.reduce(0, { partialTotal, round in
  let letters = round.components(separatedBy: " ")
  let opLetter = letters.first!
  let outcomeLetter = letters.last!
  guard !opLetter.isEmpty else {
    print("error", letters, partialTotal)
    return partialTotal
  }

  let outcomeScore: Int
  let myLetterScore: Int
  switch outcomeLetter {
  case "X": // lose
    outcomeScore = 0
    switch opLetter {
    case "A":
      myLetterScore = 3 // s
    case "B":
      myLetterScore = 1 // r
    default:
      myLetterScore = 2 // p
    }
  case "Y": // draw
    outcomeScore = 3
    switch opLetter {
    case "A":
      myLetterScore = 1 // r
    case "B":
      myLetterScore = 2 // p
    default:
      myLetterScore = 3 // s
    }
  default: // win
    outcomeScore = 6
    switch opLetter {
    case "A":
      myLetterScore = 2 // p
    case "B":
      myLetterScore = 3 // s
    default:
      myLetterScore = 1 // r
    }
  }
      
  return partialTotal + outcomeScore + myLetterScore
})
