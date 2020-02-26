import UIKit

class WordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var englishWordLabel: UILabel!
    
    func configureCell(word: WordEntity) {
        englishWordLabel.text = word.englishWord
    }
    
}
