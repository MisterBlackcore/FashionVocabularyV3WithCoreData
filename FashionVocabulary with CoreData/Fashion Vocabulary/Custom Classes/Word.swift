import Foundation
import UIKit

class Word {
    
    var englishWord:String
    var belarusianWord:String
    var englishDefinition:String
    var belarusianDefinition:String
    var wordImage:UIImage
    
    init (englishWord: String,belarusianWord: String,englishDefinition: String,belarusianDefinition: String,wordImage: UIImage) {
        self.englishWord = englishWord
        self.belarusianWord = belarusianWord
        self.englishDefinition = englishDefinition
        self.belarusianDefinition = belarusianDefinition
        self.wordImage = wordImage
    }
    
}
