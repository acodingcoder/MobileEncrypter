import Foundation

struct Defaults {
    
    static let userManager = Defaults()
    static var pin: String!
    
    func setDefaults(){
        
        let defaults = UserDefaults.standard
        
        defaults.set(Defaults.pin, forKey: "pin")
    }
}

class UserDefaultData {
    
    static let localDataManager = UserDefaultData()
    
    private let defaults = UserDefaults.standard
    
    private init(){
        print("User defaults Initialized")
    }
    
    var pin : String {
        return defaults.string(forKey: "pin") ?? ""
    }
    
    deinit {
        print("Gone with the wind")
    }
}
