//
//  ViewController.swift
//  Fitness Counter
//
//  Created by ZIYA BERK KAPLAN on 2.08.2022.
//
import UIKit

class HomeVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var weightButton: UIButton!
    @IBOutlet weak var goalWeightButton: UIButton!
    @IBOutlet weak var caloriesLabelButton: UIButton!
    @IBOutlet weak var progressViewWater: UIProgressView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var waterChangeButton: UIButton!
    @IBOutlet weak var waterLabel: UILabel!
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0

    var weights = [30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,56,57,58,59,60,61,62,63,64,65,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        weights.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = String(weights[row])
        label.sizeToFit()
        return label
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weightButton.layer.cornerRadius = 25
        weightButton.layer.masksToBounds = true
        
        goalWeightButton.layer.cornerRadius = 25
        goalWeightButton.layer.masksToBounds = true
        
        let progressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 150, height: 150), lineWidth: 15, rounded: false)
        
        progressView.progressColor = UIColor(rgb: 0xaeacf9)
        progressView.trackColor = .lightGray
        progressView.timeToFill = 1.5
        
        progressView.center = view.center
        
        view.addSubview(progressView)
        
        progressView.progress = 0.6
        
        caloriesLabelButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        waterChangeButton.addTarget(self, action: #selector(showAlertWater), for: .touchUpInside)
                                      
        self.view.bringSubviewToFront(stackView)

    }
    
    @objc private func showAlert() {
        let alert = UIAlertController(
            title: "Enter Calories", message: "Please enter your calorie intake", preferredStyle: .alert
        )
        
        alert.addTextField { field in
            field.placeholder = "Calories"
            field.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            let fields = alert.textFields
            let calorieField = fields![0]
            let calorie = calorieField.text
            let calorieProgress = Float(calorie!)! / Float(2000)
            let progressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 150, height: 150), lineWidth: 15, rounded: false)
            
            progressView.progressColor = UIColor(rgb: 0xaeacf9)
            progressView.trackColor = .lightGray
            progressView.timeToFill = 1.5
            
            progressView.center = self.view.center
            
            self.view.addSubview(progressView)
            
            progressView.progress = calorieProgress
            self.caloriesLabelButton.setTitle("\(calorie ?? "") kcal", for: .normal)
            
            self.view.bringSubviewToFront(self.stackView)
        }))
        present(alert, animated: true)
    }
    
    @objc private func showAlertWater() {
        let alert = UIAlertController(
            title: "Enter Water", message: "Please enter your water intake", preferredStyle: .alert
        )
        
        alert.addTextField { field in
            field.placeholder = "Water"
            field.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            let fields = alert.textFields
            let waterField = fields![0]
            let water = waterField.text
            self.waterLabel.text = "\(water ?? "") ml / 2500 ml"
            let progress = Float(water!)! / Float(2500)
            self.progressViewWater.setProgress(Float(progress), animated: true)
            
            
        }))
        present(alert, animated: true)
    }

    @IBAction func popUpPickerCurrentWeight(_ sender: Any) {
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
    
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        vc.view.addSubview(pickerView)
        
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Select Weight", message: "", preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = weightButton
        alert.popoverPresentationController?.sourceRect = weightButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            let selectedWeight = self.weights[self.selectedRow]
            self.weightButton.setTitle("\(String(selectedWeight)) kg", for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func popUpPickerGoalWeight(_ sender: Any) {
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
    
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        vc.view.addSubview(pickerView)
        
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Select Weight", message: "", preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = weightButton
        alert.popoverPresentationController?.sourceRect = weightButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            let selectedWeight = self.weights[self.selectedRow]
            self.goalWeightButton.setTitle("\(String(selectedWeight)) kg", for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

