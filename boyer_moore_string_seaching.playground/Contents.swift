//: Playground - noun: a place where people can play

// Bad character rule
extension String {
    func indexOf(of pattern: String) -> Index? {
        // Create the skip table
        let patternLen = pattern.characters.count
        
        guard patternLen > 0, patternLen <= characters.count else { return nil }
       
        var skipTable = [Character: Int]()
        for (i, e) in pattern.characters.enumerated() {
            skipTable[e] = patternLen - i - 1
        }
        // Scanning from right to left
        var sourceFlag = index(startIndex, offsetBy: patternLen - 1)
        let lastChar = pattern[index(before: pattern.endIndex)]
        
        func findMatch() -> (Index, Bool) {
            var sourceSearchIdx  = sourceFlag
            var patternSearchIdx = index(before: pattern.endIndex)
            repeat {
                // not found
                if (self[sourceSearchIdx] != pattern[patternSearchIdx]) { return (sourceSearchIdx, false) }
                
                // found (bound condition)
                if (patternSearchIdx == pattern.startIndex) { return (sourceSearchIdx, true) }
                // Iterate XD
                sourceSearchIdx = index(before: sourceSearchIdx)
                patternSearchIdx = index(before: patternSearchIdx)
            } while (true)
        }
        
        while sourceFlag < endIndex {
            let (longestIndex, isMatch) = findMatch()
            let c = self[longestIndex]
            // found the match
            if (isMatch) { return longestIndex }
            // not found, we keep iterate the source flag until find the mismatch, that we
            // know how many alignments we have to skip.
            sourceFlag = index(sourceFlag, offsetBy: skipTable[c] ?? 1, limitedBy: endIndex) ?? endIndex
        }
        
        return nil
    }
}

let text = "THIS EXAMPLE IS NOT SIMPLE"
let chineses = "塞納河畔，左岸的咖啡。我手一杯，品嚐你的美。"
text.indexOf(of: "EXAMPLE")
text.indexOf(of: "SIMPLE")
chineses.indexOf(of: "咖啡")
chineses.indexOf(of: "美")
