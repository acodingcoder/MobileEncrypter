import Foundation
import UIKit

struct Defaults {
    
    static let userManager = Defaults()
    static var pin: String!
    static var imagesData: [String] = UserDefaultData.localDataManager.imagesData
    static var images: [UIImage] = []
    
    func setDefaults() {
        let defaults = UserDefaults.standard
        
        defaults.set(Defaults.pin, forKey: "pin")
    }
    
    func setImages() {
        let defaults = UserDefaults.standard
        
        defaults.set(Defaults.imagesData, forKey: "imagesData")
    }
    
    func loadImages() {
        
        for string in Defaults.imagesData {
            let dataDecoded : Data = Data(base64Encoded: string, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            
            Defaults.images.append(decodedimage!)
        }
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
    
    var imagesData: [String] {
        return defaults.array(forKey: "imagesData") as! [String]
    }
    
    deinit {
        print("Gone with the wind")
    }
}

