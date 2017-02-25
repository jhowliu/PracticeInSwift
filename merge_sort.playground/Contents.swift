//: Playground - noun: a place where people can play

// split the array
func mergesort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }
    
    let middle: Int = array.count / 2
    
    let leftArray = mergesort(Array(array[0..<middle]))
    let rightArray = mergesort(Array(array[middle..<array.count]))
   
    // for merge
    return merge(leftArray, rightArray)
}

func merge(_ leftArray: [Int], _ rightArray: [Int]) -> [Int] {
    var i = 0, j = 0
    var result = [Int]()
    print(leftArray, rightArray)
    while i < leftArray.count && j < rightArray.count {
        // The data of right array is less than left, so add it !
        guard leftArray[i] < rightArray[j] else {
            result.append(rightArray[j])
            j += 1
            continue
        }
        guard leftArray[i] > rightArray[j] else {
            result.append(leftArray[i])
            i += 1
            continue
        }
    }
    
    // add the remaining data
    while i < leftArray.count { result.append(leftArray[i]); i += 1 }
    while j < rightArray.count { print("GG"); result.append(rightArray[j]); j += 1 }
    
    return result
}


let array = [100, 10, 1000, 10000, 1, -100]
mergesort(array)

let array2 = [100, 100, 1000, 10000, 1, -100]
mergesort(array2)

