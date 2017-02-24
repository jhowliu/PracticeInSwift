//: Playground - noun: a place where people can play

/*
   Time Complexity
   1. Average Cost = O(nlogn)
   2. Worst Cost = O(n^2) 
      if it picked the worst pivot 
      (So we can use the "Median-of-Three" that pick first, middle and last value to find the median as the pivot.)
      median = max(min(a,b), min(max(a, b), c)
*/
func quicksort(_ elements: inout [Int], left: Int, right: Int) {
    if (right > left) {
        let pivot = elements[left]
        var i = left
        var j = right + 1
        
        while (i < j) {
            // Avoiding the index out of the bound (i<=right, j>=left)
            repeat { i += 1 } while (i <= right && elements[i] < pivot)
            repeat { j -= 1 } while (j >= left && elements[j] > pivot)
            if (i < j) { swap(&elements[i], &elements[j]) }
        }
        if (i-1 != left) { swap(&elements[i-1], &elements[left]) }
       
        quicksort(&elements, left: left, right: i-1)
        quicksort(&elements, left: i, right: right)
    }
}

var unsorted = [100, 1000, 10000, 1000, 1]

quicksort(&unsorted, left: 0, right: unsorted.count-1)

print(unsorted)