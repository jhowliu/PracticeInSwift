//: Playground - noun: a place where people can play

class Node {
    let value: Int
    var next: Node?
    
    init(value: Int, next: Node?) {
        self.value = value
        self.next = next
    }
}

// implement a linked list as 1 -> 2 -> 3 -> nil
let thirdNode = Node(value: 3, next: nil)
let secondNode = Node(value: 2, next: thirdNode)
let firstNode = Node(value: 1, next: secondNode)

func printNodes(head: Node?) {
    var currentNode: Node? = head
    while currentNode != nil {
        print(currentNode?.value ?? -1)
        currentNode = currentNode?.next
    }
}

func reverseList(head: Node?) -> Node? {
    // Class is reference type in swift, so we have to create a new copy !
    var tail: Node? = Node(value: (head?.value)!, next: nil)
    
    var currentNode: Node? = head?.next
    var nextNode: Node?
    
    while currentNode != nil {
        nextNode = currentNode?.next
        currentNode?.next = tail
        tail = currentNode
        currentNode = nextNode
    }
    
    return tail
 
    /*
    // much cleaner solution
    var currentNode: Node? = head
    
    var prev: Node?
    var next: Node?
   
    while currentNode != nil {
        next = currentNode?.next
        currentNode?.next = prev
        prev = currentNode
        currentNode = next
    }
    
    return prev
    */
}



let testNode = firstNode

print("Original linked list")
printNodes(head: testNode)
print("After reversing")
printNodes(head: reverseList(head: testNode))
