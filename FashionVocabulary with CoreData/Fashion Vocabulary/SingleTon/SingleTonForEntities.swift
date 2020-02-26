import Foundation
import CoreData
import UIKit

class SingleTonForEntities {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var wordEntitiesArray:[WordsArrayEntity] = []
    var wordEntities:[[WordEntity]] = []
    var englishWordArray:[String] = []
    
    static let shared = SingleTonForEntities()
    private init () {}
    
    func getWordsCounted(index: Int) -> Int {
        return wordEntities[index].count
    }
    
    func getWords() -> [[WordEntity]] {
        return wordEntities
    }
    
    func initialize() {
        let fetchRequest:NSFetchRequest<WordsArrayEntity> = WordsArrayEntity.fetchRequest()
        
        var records = 0
        
        do {
            let count = try context.count(for: fetchRequest)
            records = count
            print(records)
        } catch {
            print(error.localizedDescription)
        }
        
        guard records == 0 else { return }
        
        let wordEntityArrayA = WordsArrayEntity(context: context)
        let wordEntityArrayB = WordsArrayEntity(context: context)
        let wordEntityArrayC = WordsArrayEntity(context: context)
        let wordEntityArrayD = WordsArrayEntity(context: context)
        let wordEntityArrayE = WordsArrayEntity(context: context)
        let wordEntityArrayF = WordsArrayEntity(context: context)
        let wordEntityArrayG = WordsArrayEntity(context: context)
        let wordEntityArrayH = WordsArrayEntity(context: context)
        let wordEntityArrayI = WordsArrayEntity(context: context)
        let wordEntityArrayJ = WordsArrayEntity(context: context)
        let wordEntityArrayK = WordsArrayEntity(context: context)
        let wordEntityArrayL = WordsArrayEntity(context: context)
        let wordEntityArrayM = WordsArrayEntity(context: context)
        let wordEntityArrayN = WordsArrayEntity(context: context)
        let wordEntityArrayO = WordsArrayEntity(context: context)
        let wordEntityArrayP = WordsArrayEntity(context: context)
        let wordEntityArrayQ = WordsArrayEntity(context: context)
        let wordEntityArrayR = WordsArrayEntity(context: context)
        let wordEntityArrayS = WordsArrayEntity(context: context)
        let wordEntityArrayT = WordsArrayEntity(context: context)
        let wordEntityArrayU = WordsArrayEntity(context: context)
        let wordEntityArrayV = WordsArrayEntity(context: context)
        let wordEntityArrayW = WordsArrayEntity(context: context)
        let wordEntityArrayX = WordsArrayEntity(context: context)
        let wordEntityArrayY = WordsArrayEntity(context: context)
        let wordEntityArrayZ = WordsArrayEntity(context: context)
        let wordEntityArrayForOtherCharacters = WordsArrayEntity(context: context)
        
        wordEntitiesArray = [  wordEntityArrayA,
                              wordEntityArrayB,
                              wordEntityArrayC,
                              wordEntityArrayD,
                              wordEntityArrayE,
                              wordEntityArrayF,
                              wordEntityArrayG,
                              wordEntityArrayH,
                              wordEntityArrayI,
                              wordEntityArrayJ,
                              wordEntityArrayK,
                              wordEntityArrayL,
                              wordEntityArrayM,
                              wordEntityArrayN,
                              wordEntityArrayO,
                              wordEntityArrayP,
                              wordEntityArrayQ,
                              wordEntityArrayR,
                              wordEntityArrayS,
                              wordEntityArrayT,
                              wordEntityArrayU,
                              wordEntityArrayV,
                              wordEntityArrayW,
                              wordEntityArrayX,
                              wordEntityArrayY,
                              wordEntityArrayZ,
                              wordEntityArrayForOtherCharacters]
        
        var index = 0
        for entity in wordEntitiesArray {
            entity.arrayName = SingleTon.shared.sectionName[index]
            addWordsToWordsArrayEntity(entity: entity, words: SingleTon.shared.wordsArrayInAlphabeticalOrder[index])
            index += 1
        }
        
        saveContext()
        
    }
    
    func addWordsToWordsArrayEntity(entity: WordsArrayEntity, words: [Word]) {
        if words.count != 0 {
            for element in words {
                let word = WordEntity(context: context)
                word.belarusianDefinition = element.belarusianDefinition
                word.englishDefinition = element.englishDefinition
                word.belarusianWord = element.belarusianWord
                word.englishWord = element.englishWord
                let data = element.wordImage.pngData()
                word.wordImage = data
                entity.addToWordEntities(word)
            }
        }
    }
    
    func loadCoreData() {
        var sortedArray:[WordsArrayEntity] = []
        
        let fetchRequest:NSFetchRequest<WordsArrayEntity> = WordsArrayEntity.fetchRequest()
        
        do {
            let result = try context.fetch(fetchRequest)
            for letter in SingleTon.shared.sectionName {
                for element in result {
                    if element.arrayName == letter {
                        sortedArray.append(element)
                        break
                    }
                }
            }
            wordEntitiesArray = sortedArray
        } catch {
            print(error.localizedDescription)
        }
        
        var index = 0
        for entity in wordEntitiesArray {
            let array = sorting(wordArray: entity.wordEntities?.allObjects as! [WordEntity])
            wordEntities.append(array)
            index += 1
        }
    }
    
    func deleteWordFromVocabulary(word: WordEntity,indexPath: Int) {
        var wordStartsFromLetter = false
        if let firstCharacter:Character = word.englishWord?.first {
            var index = 0
            for array in wordEntities {
                if SingleTon.shared.sectionName[index].lowercased() == firstCharacter.lowercased() {
                    var newArray = array
                    context.delete(word)
                    newArray.remove(at: indexPath)
                    newArray = sorting(wordArray: newArray)
                    wordEntities[index] = newArray
                    wordStartsFromLetter = true
                }
                index += 1
            }
        }
        
        if wordStartsFromLetter == false {
            var newArray = wordEntities[26]
            context.delete(word)
            newArray.remove(at: indexPath)
            newArray = sorting(wordArray: newArray)
            wordEntities[26] = newArray
        }
        saveContext()
    }
    
    func addNewWordToVocabulary(word: WordEntity!) {
        var wordStartsFromLetter = false
        word.englishWord = word.englishWord!.trimmingCharacters(in: .whitespacesAndNewlines)
        if let firstCharacter:Character = word.englishWord?.first {
            var index = 0
            for array in wordEntities {
                if SingleTon.shared.sectionName[index].lowercased() == firstCharacter.lowercased() {
                    var newArray = array
                    newArray.append(word)
                    newArray = sorting(wordArray: newArray)
                    addToWordArrayEntity(word: word, index: index)
                    wordEntities[index] = newArray
                    wordStartsFromLetter = true
                }
                index += 1
            }
        }
        if wordStartsFromLetter == false {
            var newArray = wordEntities[26]
            newArray.append(word)
            newArray = sorting(wordArray: newArray)
            addToWordArrayEntity(word: word, index: 26)
            wordEntities[26] = newArray
        }
        saveContext()

    }
    
    func addToWordArrayEntity(word: WordEntity, index: Int) {
        for entity in wordEntitiesArray {
            if entity.arrayName == SingleTon.shared.sectionName[index] {
                entity.addToWordEntities(word)
            }
        }
    }
    
    func sorting(wordArray: [WordEntity]) -> [WordEntity] {
        var temporaryEnglishWordArray:[String] = []
        for element in wordArray {
            temporaryEnglishWordArray.append(element.englishWord!)
            temporaryEnglishWordArray.sort(by: { $0 < $1 })
        }
        var wordEntityArrayToReturn:[WordEntity] = []
            for englishWord in temporaryEnglishWordArray {
                for element in wordArray {
                    if element.englishWord == englishWord {
                        wordEntityArrayToReturn.append(element)
                    }
                }
            }
        return wordEntityArrayToReturn
    }
    
    func saveContext() {
        do {
            try context.save()
            print("Success!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
