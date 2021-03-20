//
//  EvaluationViewController.swift
//  DepTes
//
//  Created by Prince Alvin Yusuf on 16/03/21.
//

import UIKit
import SafariServices
import StoreKit
import RealmSwift

class EvaluationViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var additionalLabel: UILabel!
    @IBOutlet weak var findHelpButton: UIButton!
    @IBOutlet weak var findHelpLabel: UILabel!
    
    var viewModel: EvaluationViewModel? {
        didSet {
            if let viewModel = viewModel {
                updateUIWithViewModel(viewModel)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let viewModel = viewModel {
            updateUIWithViewModel(viewModel)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(fontSizeChanged), name: UIContentSizeCategory.didChangeNotification, object: nil)
        
        let newEvaluation = EvaluationModel()
        newEvaluation.diagnosis = viewModel!.diagnosis
        newEvaluation.diagnosisText = viewModel!.diagnosisText
        newEvaluation.explanationText = viewModel!.explanationText
        newEvaluation.score = viewModel!.score
        newEvaluation.suicidalText = (viewModel?.suicidalText)!
        newEvaluation.dateCreated = Date()
        
        self.save(evaluation: newEvaluation)
    }
    
    func updateUIWithViewModel(_ viewModel: EvaluationViewModel) {
        guard isViewLoaded else { return }
        
        let diagnosisText = viewModel.diagnosisText as NSString
        let font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
        let boldFont = UIFont.boldSystemFont(ofSize: font.pointSize)
        let attributedDiagnosisText = NSMutableAttributedString(string: viewModel.diagnosisText,
                                                                attributes: [.font: font])
        let diagnosisRange = diagnosisText.range(of: viewModel.diagnosis)
        attributedDiagnosisText.addAttribute(.font, value: boldFont, range: diagnosisRange)
        resultLabel.attributedText = attributedDiagnosisText
        additionalLabel.text = viewModel.suicidalText
        
        if viewModel.shouldDisplayFindingHelpInformation {
            findHelpButton.isHidden = false
            findHelpLabel.isHidden = false
            findHelpLabel.text = viewModel.findingHelpViewModel!.credits
        } else {
            findHelpButton.isHidden = true
            findHelpLabel.isHidden = true
        }
        
        if viewModel.shouldPromptForReview {
            SKStoreReviewController.requestReview()
            viewModel.didShowReviewPrompt()
        }
    }
    
    @objc private func fontSizeChanged() {
        if let viewModel = viewModel {
            updateUIWithViewModel(viewModel)
        }
    }
    
    
    @IBAction func viewDetailsPressed(_ sender: UIButton) {
        
        guard let detailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EvaluationDetails") as? EvaluationDetailsViewController else {
            return
        }
        
        detailsViewController.viewModel = viewModel
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    
    @IBAction func findHelpPressed(_ sender: UIButton) {
        guard let url = viewModel?.findingHelpViewModel?.url else { return }
        let safariViewController = SFSafariViewController(url: url as URL)
        safariViewController.preferredControlTintColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        present(safariViewController, animated: true, completion: nil)
    }
    

    // MARK: - SAVE THE DATA
    func save(evaluation: EvaluationModel) {
        do {
            try realm.write {
                realm.add(evaluation)
            }
        } catch {
            print("Error saving data \(error.localizedDescription)")
        }
    }

}
