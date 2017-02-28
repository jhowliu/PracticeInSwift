//: Playground - noun: a place where people can play


/*
    Time Complexity 
    1. heapsort : O(NlogN)
    2. heapify : O(logN)
    3. search  : O(N)
*/
public struct Heap {
    var heap = [Int]()
    
    init(_ array: [Int]) {
        buildHeap(fromArray: array)
    }
    
    var isEmpty: Bool {
        return heap.isEmpty
    }
    
    var count: Int {
        return heap.count
    }
    // Inline these function because we often use these function
    @inline (__always) func leftChildIndex(ofIndex: Int) -> Int {
        return ofIndex * 2 + 1
    }
    
    @inline (__always) func rightChildIndex(ofIndex: Int) -> Int {
        return ofIndex * 2 + 2
    }
    
    @inline (__always) func parentIndex(ofIndex: Int) -> Int {
        return (ofIndex - 1) / 2
    }
    
    fileprivate mutating func buildHeap(fromArray array: [Int]) {
        heap = array
        for i in stride(from: array.count / 2 - 1, through: 0, by: -1) {
            shiftDown(index: i, heapSize: heap.count)
        }
        
        print("build ending \(heap)")
    }
    // Heapify - (only for max-heap now)
    mutating func shiftDown(index: Int, heapSize: Int) {
        var parentIndex = index
        
        while true {
            var maxIndex = parentIndex
            
            let leftChildIndex = self.leftChildIndex(ofIndex: parentIndex)
            let rightChildIndex = leftChildIndex + 1
            if (leftChildIndex < heapSize && heap[leftChildIndex] > heap[maxIndex]) {
                maxIndex = leftChildIndex
            }
            
            if (rightChildIndex < heapSize && heap[rightChildIndex] > heap[maxIndex]) {
                maxIndex = rightChildIndex
            }
            
            if (parentIndex == maxIndex) { break }
            swap(&heap[parentIndex], &heap[maxIndex])
            parentIndex = maxIndex
        }
    }
    
    mutating func shiftDown() {
        shiftDown(index: 0, heapSize: heap.count)
    }
    
    mutating func shiftUp(index: Int) {
        var childIndex = index
        var parentIndex = self.parentIndex(ofIndex: index)
        
        while childIndex > 0 {
            if (heap[childIndex] > heap[parentIndex]) {
                swap(&heap[childIndex], &heap[parentIndex])
            }
            
            childIndex = parentIndex
            parentIndex = self.parentIndex(ofIndex: childIndex)
        }
    }
    
    
    // Insert the given value into the end of heap
    mutating func insert(value: Int) {
        heap.append(value)
        shiftUp(index: heap.count-1)
    }
    
    // remove the root of heap and return it. O(logN)
    mutating func remove() -> Int? {
        if isEmpty { return nil }
        
        let root = heap.first
      
        // swap the root and the last value
        heap[0] = heap[heap.count - 1]
        heap.removeLast()
        shiftDown()
        
        return root
    }
    
    mutating func removeAt(_ index: Int) -> Int? {
        guard index < heap.count else { return nil }
        let removedValue = heap[index]
        
        heap[index] = heap[heap.count-1]
        heap.removeLast()
        // We just heapify to the changed position
        shiftDown(index: index, heapSize: count)
        
        return removedValue
    }
    
    mutating func replace(index: Int, value: Int) {
        guard index < count else { return }
        let prev = heap[index]
        heap[index] = value
        
        if (value > prev) { shiftUp(index: index) }
        if (value < prev) { shiftDown(index: index, heapSize: count) }
    }
}
// Search the heap for the give element
extension Heap {
    public func index(of element: Int) -> Int? {
        return index(of: element, 0)
    }
    
    // find the given element from the give index i
    fileprivate func index(of element: Int, _ i: Int) -> Int? {
        guard i < count else { return nil }
        
        if (heap[i] == element) { return i }
        
        // find the give element recursively, if j is not equal nil return it
        
        if let j = index(of: element, leftChildIndex(ofIndex: i)) { return j }
        if let j = index(of: element, rightChildIndex(ofIndex: i)) { return j }
        
        return nil
    }
}

extension Heap {
    public mutating func sort() {
        for i in stride(from: count - 1, through: 1, by: -1) {
            swap(&heap[0], &heap[i])
            shiftDown(index: 0, heapSize: i)
        }
    }
}

var array = [10, 100, 1, 1000, -10, 100000, 1000]

var heap = Heap(array)

print(heap.heap)

print("Start Insert 100000")
heap.insert(value: 100000)
print(heap.heap)

print("Replace the 10000 by 999999")
heap.replace(index: 1, value: 999999)
print(heap.heap)

print("Remove the the root 999999")
heap.remove()
print(heap.heap)

print("Remove the index 1")
heap.removeAt(1)!
print(heap.heap)

print("Sorting")
heap.sort()
print(heap.heap)


