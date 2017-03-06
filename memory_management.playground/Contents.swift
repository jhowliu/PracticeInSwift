// Retain cycle with class
class User {
    var name: String
    var subscriptions: [CarrierSubscription] = []
    private var phones = [Phone]()
    
    init(name: String) {
        self.name = name
        print("User \(self.name) is initialized.")
    }
    
    deinit {
        print("User \(self.name) is being deallocated.")
    }
    
    func add(phone: Phone) {
        self.phones.append(phone)
        phone.owner = self
    }
}

class Phone {
    let model: String
    weak var owner: User?
    var carrierSubscription: CarrierSubscription?
    
    init(model: String) {
        self.model = model
        print("Phone \(self.model) is initialized.")
    }
    
    deinit {
        print("Phone \(self.model) is being deallocated.")
    }
    
    func provision(carrierSubscription: CarrierSubscription) {
        self.carrierSubscription = carrierSubscription
    }
    
    func decommission() {
        self.carrierSubscription = nil
    }
}

class CarrierSubscription {
    let name: String
    let countryCode: String
    let number: String
    unowned let user: User
    
    /* Retain Cycle with closure:
       If a closure is assigned to the property of a class, and that closure
       uses instance properties of that same class, you have a reference
       cycle. So the subscription object cannot be deallocated.
     
       Example:
       lazy var completePhoneNumber: () -> String = {
           self.countryCode + " " + self.number
       }
       Solution: We use the "Capture list" which is in the brakets to solve 
                 it.
     */
     
    lazy var completePhoneNumber: () -> String = {
        [weak self] in
        return (self?.countryCode)! + " " + (self?.number)!
    }
    
    
    init(name: String, countryCode: String, number: String, user: User) {
        self.name = name
        self.countryCode = countryCode
        self.number = number
        self.user = user
        
        print("CarrierSubscription \(name) is initialized")
    }
    
    deinit {
        print("CarrierSubscription \(name) is being deallocated")
    }
}

do {
    let john = User(name: "John")
    let iphone = Phone(model: "iPhone 7")
    // Create retain cycle
    
    /* the phones array (in User) strong refer to Phone object
       and the owner (in Phone) is strong refer to User object, so
       we got the retain cycle.
     
       Solution: add the weak keyword in front of owner which in Phone
                 class.
    */
    john.add(phone: iphone)
    
    /* carrierSubscription variable (in Phone) strong refer to CarrierSub
       object, phone variable (in User) strong refer to Phone object and
       user variable (in CarrierSub) strong refer to User object. This
       situation cause the "Retain Cycle".
     
       Solution: add the unowned keyword in front of user variable which 
                 in CarrierSub class.
     */
    let subscription = CarrierSubscription(name: "TelBel", countryCode: "0032", number: "3333333", user: john)
    iphone.provision(carrierSubscription: subscription)
    print(subscription.completePhoneNumber)
}



