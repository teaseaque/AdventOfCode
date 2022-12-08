import Foundation

let inputURL = Bundle.main.url(forResource: "input4", withExtension: "txt")
let input = try String(contentsOf: inputURL!, encoding: String.Encoding.utf8)

let rangePairs = input.components(separatedBy: "\n")

// MARK: - Helper

func getRangeSets(for pair: String) -> (Set<Int>, Set<Int>) {
  let elfPairRanges = pair.components(separatedBy: ",")
  let elf1RangeNumbers = elfPairRanges.first!.components(separatedBy: "-")
  let elf2RangeNumbers = elfPairRanges.last!.components(separatedBy: "-")
  let elf1RangeSet = Set(Int(elf1RangeNumbers.first!)!...Int(elf1RangeNumbers.last!)!)
  let elf2RangeSet = Set(Int(elf2RangeNumbers.first!)!...Int(elf2RangeNumbers.last!)!)
  return (elf1RangeSet, elf2RangeSet)
}

// MARK: - Part 1

let countOfContainedRanges = rangePairs.reduce(0) { partialResult, elfPair in
  guard !elfPair.isEmpty else { return partialResult }

  let elfRangeSets = getRangeSets(for: elfPair)

  if elfRangeSets.0.isSubset(of: elfRangeSets.1) || elfRangeSets.1.isSubset(of: elfRangeSets.0) {
    return partialResult + 1
  } else {
    return partialResult
  }
}

print("countOfContainedRanges", countOfContainedRanges)

// MARK: - Part 2

let countOfOverlappingRanges = rangePairs.reduce(0) { partialResult, elfPair in
  guard !elfPair.isEmpty else { return partialResult }

  let elfRangeSets = getRangeSets(for: elfPair)
  
  if elfRangeSets.0.contains(where: { elfRangeSets.1.contains($0) }) {
    return partialResult + 1
  } else {
    print(elfPair)
    return partialResult
  }
}

print("countOfOverlappingRanges", countOfOverlappingRanges)
