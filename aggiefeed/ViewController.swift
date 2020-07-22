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
    static let detailSegueID = "MasterToDetail"

    var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(named: "Aggie Gold")
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
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.refreshControl = refresher
        
        navigationItem.title = "Aggie Feed"
        navigationController?.navigationBar.barStyle = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .refresh, target: self, action: #selector(self.getNewCells))
        
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
        if segue.identifier == ViewController.detailSegueID {
            let destVC = segue.destination as! DetailViewController
            destVC.cell = sender as? Cell
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ViewController.detailSegueID, sender: listOfCells[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.8, animations: {
            cell.contentView.alpha = 1
        })
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
        cell.contentView.alpha = 0
        return cell
    }
}
