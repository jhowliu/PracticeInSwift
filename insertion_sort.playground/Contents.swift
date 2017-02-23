//: Playground - noun: a place where people can play

/*
    Inplace Sorting - Need O(1) Space Complexity
 
    Time Complexity
    1. worst-case is O(n^2) because there are two nested loops. [1000, 100, 10, 1]
 
    Conculsion
    1. The insertion sort is actually very fast for sorting the small arrays.
*/

// No-Swaping
func insertionSortOutPlace(_ elements: [Int]) -> [Int] {
    var sorted = elements
    
    for i in 1..<sorted.count {
        let tmp = sorted[i] // create a variable to keep value (out-place)
        var index = i - 1
        while index > 0 && sorted[i] < sorted[index] {
            sorted[index + 1] = sorted[index]
            index -= 1
        }
        
        sorted[index] = tmp
    }
    
    return sorted
}

// Ascending Order - Swaping
func insertionSort(_ elements: [Int]) -> [Int] {
    var sorted = elements
    for i in 1..<sorted.count {
        var index = i
        
        // It will be descending, if it change to "sorted[index] > sorted[index - 1]"
        while index > 0 && sorted[index] < sorted[index - 1] {
            swap(&sorted[index], &sorted[index-1])
            index -= 1
        }
    }
    
    return sorted
}

// Dscending Order 


var array = [100, 1000, 1, 10, 10000]

insertionSort(array)
insertionSortOutPlace(array)
