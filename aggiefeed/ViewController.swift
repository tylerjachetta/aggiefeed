//
//  ViewController.swift
//  aggiefeed
//
//  Created by Tyler Jachetta on 7/16/20.
//  Copyright © 2020 Tyler Jachetta. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {

    @IBOutlet var table: UITableView!
    
    var listOfCells = [Cell]() {
        didSet {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
        let cellsRequest = CellsRequest()
        cellsRequest.getData { [weak self] result in
            switch result {
            case.failure(let error):
                print(error)
            case.success(let cells):
                self?.listOfCells = cells
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MasterToDetail" {
            let destVC = segue.destination as! DetailViewController
            destVC.cell = sender as? Cell
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = listOfCells[indexPath.row]
        performSegue(withIdentifier: "MasterToDetail", sender: selectedCell)
        
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection second: Int) -> Int {
        return listOfCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.title.text = listOfCells[indexPath.row].title
        cell.displayName.text = listOfCells[indexPath.row].actor.displayName
        return cell
    }
}
