import Foundation

let inputURL = Bundle.main.url(forResource: "input1", withExtension: "txt")
let input = try String(contentsOf: inputURL!, encoding: String.Encoding.utf8)

// MARK: - Part 1

let arrayOfElves: [String] = input.components(separatedBy: "\n\n")
let arrayOfElfTotals = arrayOfElves.map { elf in
  let items = elf.components(separatedBy: "\n")
  return items.reduce(0, { $0 + (Int($1) ?? 0) })
}

print("maxOfArrayOfElfTotals", arrayOfElfTotals.max()!)

// MARK: - Part 2

let sortedElfTotalArray = arrayOfElfTotals.sorted(by: { $0 > $1 })
let topThreeElfs = sortedElfTotalArray.prefix(3)
let topThreeGrandTotal = topThreeElfs.reduce(0, +)

print(sortedElfTotalArray.prefix(3), topThreeGrandTotal)

print("top3InArrayOfElfTotals", sortedElfTotalArray.prefix(3))
