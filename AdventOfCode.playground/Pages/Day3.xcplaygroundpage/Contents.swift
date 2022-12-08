import Foundation

let inputURL = Bundle.main.url(forResource: "input3", withExtension: "txt")
let input = try String(contentsOf: inputURL!, encoding: String.Encoding.utf8)

let alphabet = "abcdefghijklmnopqrstuvwxyz"

let rucksacks = input.components(separatedBy: "\n")

// MARK: - Part 1

let grandTotalPriorities = rucksacks.reduce(0) { partialResult, sack in
  let sackLength = sack.count
  let halfSack1 = sack.prefix(sackLength / 2)
  let halfSack2 = sack.suffix(sackLength / 2)
  if let match = halfSack1.first(where: { halfSack2.contains($0) }) {
    if let alphabetIndex = alphabet.firstIndex(where: { String($0) == match.lowercased() }) {
      let priority = alphabet.distance(from: alphabet.startIndex,to: alphabetIndex)
      let totalPriority = (priority + 1) + (match.isUppercase ? 26 : 0)
      return partialResult + totalPriority
    }
  }
  
  return partialResult
}

print("grandTotalPriorities", grandTotalPriorities)

// MARK: - Part 2

var runningGroupGrandTotal: Int = 0

for startIndex in stride(from: 0, to: rucksacks.endIndex, by: 3) {
  let uniqueLetters = Set(rucksacks[startIndex])
  for character in uniqueLetters {
    let isInSeconds = rucksacks[startIndex + 1].contains(character)
    let isInThirds = rucksacks[startIndex + 2].contains(character)
    
    if isInSeconds && isInThirds,
       let alphabetIndex = alphabet.firstIndex(where: { String($0) == character.lowercased() }) {
      let priority = alphabet.distance(from: alphabet.startIndex,to: alphabetIndex)
      let totalPriority = (priority + 1) + (character.isUppercase ? 26 : 0)
      runningGroupGrandTotal += totalPriority
    }
  }
}

print("runningGroupGrandTotal", rucksacks.count, rucksacks.count % 3, runningGroupGrandTotal)

