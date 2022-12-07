//
//  SalesViewController.swift
//  BookStoreApp
//
//  Created by TEO on 6/12/22.
//

import UIKit

struct SaleDTO{
    let bookName: String
    let bookValue: Double
    let numberBooksSold: Double
    let paymentMedium: String
}

class SalesViewController: UIViewController {
    
    private struct Const {
        static let segueIdentifier = "goToSummary"
        static let connectionError = "Fue imposible enviar la información al servidor"
        static let invalidValues = "Hay al menos un valor no válido"
        static let errorTitle = "Error"
        static let actionTitle = "Cancelar"
        static let bookNameDefault = String()
        static let paymentMediumDefault = String()
    }

    @IBOutlet weak var bookNameTextField: UITextField!
    @IBOutlet weak var bookPriceTextField: UITextField!
    @IBOutlet weak var numberOfBookTextField: UITextField!
    @IBOutlet weak var paymentMediumTextField: UITextField!
    
    let possibleFailures = [1,2,3,4]
    var bookName = String()
    var bookValue: Double = 0
    var numberBooksSold: Double = 0
    var paymentMedium = String()
    
    @IBAction func sellButtonPressed() {
        sendSalesData()
    }
    
    private func sendSalesData(){
        let numberObtained = Int.random(in: 1...7)
        if possibleFailures.contains(numberObtained) {
            executeAlert(title: Const.errorTitle, message: Const.connectionError, actionTitle: Const.actionTitle)
        } else {
            processSaleData()
        }
    }
    
    private func processSaleData(){
        getData()
        validateData()
    }
    
    private func getData(){
        bookName = bookNameTextField.text ?? Const.bookNameDefault
        
        if let bookPrice = bookPriceTextField.text {
            if let bookPrice = Double(bookPrice){
                bookValue = bookPrice
            }
        }
        
        if let numberBooks = numberOfBookTextField.text {
            if let numberBooks = Double(numberBooks){
                numberBooksSold = numberBooks
            }
        }
        
        paymentMedium = paymentMediumTextField.text ?? Const.paymentMediumDefault
        
    }
    
    private func validateData(){
        if areThereAnyInvalidValues() {
            executeAlert(title: Const.errorTitle, message: Const.invalidValues, actionTitle: Const.actionTitle)
        } else {
            executeTransition()
        }
    }
    
    private func areThereAnyInvalidValues() -> Bool {
        return bookName.isEmpty || bookValue.isEqual(to: 0) || numberBooksSold.isEqual(to: 0) || paymentMedium.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let summaryViewController =  segue.destination as? SummaryViewController {
            summaryViewController.sale = SaleDTO(bookName: bookName, bookValue: bookValue, numberBooksSold: numberBooksSold, paymentMedium: paymentMedium)
        }
    }
    
    private func executeAlert(title: String, message: String, actionTitle: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }
    
    private func executeTransition(){
        performSegue(withIdentifier: Const.segueIdentifier, sender: self)
    }
    
}

