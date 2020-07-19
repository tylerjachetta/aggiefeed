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
    
    var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(getNewCells), for: .valueChanged)
        return refreshControl
    }()
    
    var listOfCells = [Cell]() {
        didSet {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .refresh, target: self, action: #selector(self.getNewCells))
        table.refreshControl = refresher
        navigationItem.title = "Aggie Feed" 
        navigationController?.navigationBar.barStyle = .black
        getNewCells()
    }
    
    
    @objc func getNewCells(){
        navigationItem.rightBarButtonItem?.isEnabled = false
        let cellsRequest = CellsRequest()
        cellsRequest.getData { [weak self] result in
            switch result {
            case.failure(let error):
                print(error)
            case.success(let cells):
                self?.listOfCells = cells
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(700)) {
            self.refresher.endRefreshing()
        }
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        if segue.identifier == "MasterToDetail" {
            let destVC = segue.destination as! DetailViewController
            destVC.cell = sender as? Cell
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MasterToDetail", sender: listOfCells[indexPath.row])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection second: Int) -> Int {
        return listOfCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.title.text = String(htmlEncodedString: listOfCells[indexPath.row].title)
        cell.displayName.text = String(htmlEncodedString: listOfCells[indexPath.row].actor.displayName)
        return cell
    }
}
