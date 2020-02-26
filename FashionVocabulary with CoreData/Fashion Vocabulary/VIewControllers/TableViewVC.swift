import UIKit
import AVFoundation

class TableViewVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addWordButton: UIButton!
    
    var activityIndicator = UIActivityIndicatorView()
    
    private var backgroundMusicPlayer: AVAudioPlayer?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Main Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SingleTonForEntities.shared.initialize()
        SingleTonForEntities.shared.loadCoreData()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        playBackgroundMusic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - IBActions
    
    @IBAction func addWordButtonIsPressed(_ sender: UIButton) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewWordViewController") as? CreateNewWordViewController {
            controller.modalPresentationStyle = .fullScreen
            self.present(controller,animated: true)
        }
    }
    
    //MARK: - Flow functions
    
    func playBackgroundMusic() {
        let backgroundMusic = URL(fileURLWithPath: Bundle.main.path(forResource: "MainOST", ofType: "mp3")!)
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        try! backgroundMusicPlayer = AVAudioPlayer(contentsOf: backgroundMusic)
        backgroundMusicPlayer!.play()
    }
    
    @objc func loadList(notification: NSNotification){
        self.tableView.reloadData()
    }
    
}

    //MARK: - Extensions

extension TableViewVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SingleTon.shared.sectionName.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if SingleTonForEntities.shared.wordEntities[section].count != 0 {
            return SingleTon.shared.sectionName[section]
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Remove") { (action, view, completion) in
            SingleTonForEntities.shared.deleteWordFromVocabulary(word: SingleTonForEntities.shared.getWords()[indexPath.section][indexPath.row], indexPath: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        action.backgroundColor = .red
        return action
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SingleTonForEntities.shared.getWordsCounted(index: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordTableViewCell", for: indexPath) as? WordTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(word: SingleTonForEntities.shared.wordEntities[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ShowWordVC") as? ShowWordVC {
            controller.word = SingleTonForEntities.shared.wordEntities[indexPath.section][indexPath.row]
            controller.wordIndex = indexPath.row
            self.present(controller, animated: true)
        }
    }
}

