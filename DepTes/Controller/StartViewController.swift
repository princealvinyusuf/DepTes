//
//  StartViewController.swift
//  DepTes
//
//  Created by Prince Alvin Yusuf on 15/03/21.
//

import UIKit
import ResearchKit
import RealmSwift

class StartViewController: UIViewController {
    @IBOutlet weak var childStartView: UIView!
    @IBOutlet weak var tableView: UITableView!

    let realm = try! Realm()
    var itemResult: Results<EvaluationModel>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadEvaluation()
        
        tableView.register(UINib(nibName: "EvaluationCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 250
        tableView.separatorStyle = .none
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !realm.isEmpty {
            childStartView.isHidden = true
            tableView.reloadData()
            loadEvaluation()
        } else {
            tableView.isHidden = true
        }
        
    }
    
    @IBAction func startTestPressed(_ sender: UIBarButtonItem) {
        let task = SelfTestTask.task()
        let taskController = ORKTaskViewController(task: task, taskRun: nil)
        taskController.delegate = self
        taskController.modalPresentationStyle = .fullScreen
        taskController.navigationBar.prefersLargeTitles = false
        
        present(taskController, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedSegue" {
            //          if let childVC = segue.destination as? ChildStartViewController {
            //Some property on ChildVC that needs to be set
        }
    }
    
    func loadEvaluation() {
        itemResult = realm.objects(EvaluationModel.self)
    }
}


extension StartViewController: ORKTaskViewControllerDelegate {
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        if reason == .completed, let results =
            taskViewController.result.results as? [ORKStepResult] {
            
            let settings = Settings()
            settings.incrementNumberOfFinishedSurveys()
            
            let evaluation = Evaluation(stepResults: results)
            
            if let evaluation = evaluation {
                
                let findingHelpInformation = FindingHelpInformation(locale: Locale.current)
                let viewModel = EvaluationViewModel(evaluation: evaluation, findingHelpInformation: findingHelpInformation, settings: settings)
                
                let evaluationViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EvaluationViewController") as! EvaluationViewController
                
                evaluationViewController.viewModel = viewModel
                
                navigationController?.pushViewController(evaluationViewController, animated: false)
            }
        }
        
        dismiss(animated: true) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
}

extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemResult!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! EvaluationCell
//        cell.textLabel?.text = itemResult![indexPath.row].score
        
        return cell
        
    }

    
    
}
