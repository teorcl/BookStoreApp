//
//  SummaryViewController.swift
//  BookStoreApp
//
//  Created by TEO on 7/12/22.
//

import UIKit

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var totalCollectLabel: UILabel!
    @IBOutlet weak var moneyImageView: UIImageView!
    var sale: SaleDTO?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI(){
        if let sale = self.sale{
            let bookName = "Nombre del libro: \(sale.bookName) "
            let collect = "Recaudo: \(sale.bookValue * sale.numberBooksSold)"
            bookNameLabel.text = bookName
            totalCollectLabel.text = collect
            moneyImageView.image = UIImage(named: sale.paymentMedium)
        }
    }
    
    
    @IBAction func onMakeANewPurchaseTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}
