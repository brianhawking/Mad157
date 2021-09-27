//
////
////  ViewController.swift
////  NotesAppBrianV
////
////  Created by Brian Veitch on 9/27/21.
////
//
//import UIKit
//
//class Note {
//    var title: String
//    var content: String
//    
//    init(title: String, content: String) {
//        self.title = title
//        self.content = content
//    }
//}
//
//class ViewController: UIViewController {
//
//    var notes: [[String]] = []
////    var notes: [Note] = []
//    
//    var row: Int = 0
//    var fileURL: URL!
//    
//    @IBOutlet weak var notesTableView: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let baseURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        fileURL = baseURL.appendingPathComponent("notes.txt")
//        
//        print(fileURL ?? "does not exist")
//        
//        loadNotes()
//        
//        setupTableView()
//        
//        
//    }
//    
//    func saveNotes() {
//        let array = NSArray(array: notes)
//        
//        do {
//            try array.write(to: fileURL)
//        } catch  {
//            print("ERROR")
//        }
//    }
//    
//    func loadNotes() {
//        if let loadedNotes:[[String]] = NSArray(contentsOf: fileURL) as? [[String]] {
//            notes = loadedNotes
//            notesTableView.reloadData()
//        }
//    }
//    
//    func setupTableView() {
//        notesTableView.delegate = self
//        notesTableView.dataSource = self
//        let nib = UINib(nibName: "NotesCell", bundle: Bundle.main)
//        notesTableView.register(nib, forCellReuseIdentifier: NotesCell.cellID)
//    }
//    
//    @IBAction func addNoteAction(_ sender: Any) {
//        performSegue(withIdentifier: "AddNoteSegue", sender: nil)
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if (segue.identifier == "AddNoteSegue") {
//            let vc = segue.destination as! AddNoteViewController
//            
//            vc.completionHandler = { title, content in
//                
//                self.notes.insert([title,content], at: 0)
//                self.notesTableView.reloadData()
//                
//                self.saveNotes()
//            }
//        }
//        
//        else if (segue.identifier == "EditNoteSegue") {
//        
//            let vc = segue.destination as! EditNoteViewController
//            row = sender as! Int
//            vc.titleText = notes[row][0]
//            vc.contentText = notes[row][1]
//            
//            vc.completionHandler = { title, content in
//                
//                self.notes[self.row][0] = title
//                self.notes[self.row][1] = content
//                self.notesTableView.reloadData()
//                
//                self.saveNotes()
//               
//            }
//        }
//          
//        
//        print(fileURL ?? "does not exist")
//    }
//    
//}
//
//extension ViewController: UITableViewDelegate {
//    
//}
//
//extension ViewController: UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return notes.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: NotesCell.cellID, for: indexPath) as! NotesCell
//        
//        cell.titleLabel.text = notes[indexPath.row][0]
//        cell.contentLabel.text = notes[indexPath.row][1]
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    
//        performSegue(withIdentifier: "EditNoteSegue", sender: indexPath.row)
//    }
//    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) ->   UITableViewCell.EditingStyle {
//        return .delete
//    }
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tableView.beginUpdates()
//            
//            notes.remove(at: indexPath.row)
//            notesTableView.deleteRows(at: [indexPath], with: .fade)
//            
//            tableView.endUpdates()
//            
//            saveNotes()
//            
//            
//        }
//    }
//    
//    
//}
//
