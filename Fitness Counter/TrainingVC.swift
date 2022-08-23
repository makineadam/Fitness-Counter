//
//  TrainingVC.swift
//  Fitness Counter
//
//  Created by ZIYA BERK KAPLAN on 16.08.2022.
//

import UIKit

class TrainingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var addTrainingButton: UIButton!
    
    struct Training {
        let title: String
        let duration: String
    }
    
    var trainings: [Training] = [
        Training(title: "Cardio", duration: "30 mins")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        addTrainingButton.addTarget(self, action: #selector(showAlertTraining), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let training = trainings[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "trainingCell", for: indexPath) as! CustomTableViewCell
        cell.trainingLabel.text = training.title
        cell.durationLabel.text = training.duration
        return cell
    }
    
    @objc private func showAlertTraining() {
        let alert = UIAlertController(
            title: "Add Training", message: "Please enter your training information", preferredStyle: .alert
        )
        alert.addTextField { field in
            field.placeholder = "Training Name"
        }
        alert.addTextField { field in
            field.placeholder = "Duration"
            field.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            let fieldsTraining = alert.textFields
            let nameField = fieldsTraining![0]
            let durationField = fieldsTraining![1]
            let trainingName = nameField.text
            let durationTime = durationField.text
            let tempTraining = Training(title: trainingName!, duration: durationTime!)
            DispatchQueue.main.async {
                self.trainings.append(tempTraining)
                self.table.reloadData()
            }
        }))
        present(alert, animated: true)
    }
    
}




