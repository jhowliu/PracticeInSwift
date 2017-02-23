//: Playground - noun: a place where people can play

/*
    Time Complexity
    1. Enqueue - O(1)
       Because an array in Swift always has some empty space at the end.
    2. Dequeue - O(n)
       We remove the first element, no the end. This is always an O(n) operation to shift the elements.
*/
public struct Queue<T> {
    private var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    init(_ args: T ...) {
        for e in args {
            array.append(e)
        }
    }
    
    public var count: Int {
        return array.count
    }
    
    public var front: T? {
        return array.first
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        return isEmpty ? nil : array.removeFirst()
    }
}
// 1, 10, 100, 1000
var myQueue = Queue<Int>(1, 10, 100, 1000)

myQueue.front

myQueue.count

// 10, 100, 1000
myQueue.dequeue()

myQueue.front

// 10, 100, 1000, 9999
myQueue.enqueue(9999)

myQueue.front

myQueue.dequeue()
myQueue.dequeue()
myQueue.dequeue()
myQueue.dequeue()
myQueue.dequeue()
