//
//  ViewController.swift
//  CryptoCrazyRxMVVM
//
//  Created by midDeveloper on 26.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    

    @IBOutlet weak var tableView: UITableView!
        
    
    var cryptoList = [Crypto]()

    let cryptoVM = CryptoViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
       
        setupBindings()
        cryptoVM.requestData()
    }
    
    
    private func setupBindings(){
        
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }
            .disposed(by: disposeBag)
        
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
                self.cryptoList = cryptos
                self.tableView.reloadData()
            }
            .disposed(by: disposeBag)
            
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var context = cell.defaultContentConfiguration()
        
        context.text = cryptoList[indexPath.row].currency
        context.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration = context
        
        return cell
    }
}

