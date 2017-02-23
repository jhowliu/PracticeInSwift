//: Playground - noun: a place where people can play

/*
   In Swift, Structures are better than classes in many circumtances.
   1. Pass by Value - More safier than mutiple reference to the same instance happens with classes
                    - Less worry about memory leak and multiple thread racing to get/change the same variable
 
*/
public struct Stack<T> {
    private var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ value: T) {
        array.append(value)
    }
    // if you wanna change the properties, you have to add mutating into your function
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public func top() -> T? {
        return array.last
    }
    
    init(_ args: T ...) {
        for value in args {
            push(value)
        }
    }
}


var myStack = Stack<Int>(1, 10, 100, 1000)

myStack.pop()

myStack.top()

myStack.push(9999)

myStack.top()
