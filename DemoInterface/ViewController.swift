//
//  ViewController.swift
//  DemoInterface
//
//  Created by gerardo on 13/12/17.
//  Copyright © 2017 Orbis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    private let refreshControl = UIRefreshControl()
    private let searchController = UISearchController(searchResultsController: nil)
    let label = UILabel()
    let vistainterna = UIView()
    let boton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "TypeSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "TypeSearchTableViewCell")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            tableview.refreshControl = refreshControl
            navigationItem.searchController = searchController

        } else {
            tableview.addSubview(refreshControl)
            tableview.tableHeaderView = searchController.searchBar
        }
        setupView(lbl: "507 empleos en el Perú", btn: "Más recientes ▼")
    }

    func setupView(lbl:String!, btn:String!) {
        
        vistainterna.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        vistainterna.layer.borderWidth = 1
        vistainterna.layer.borderColor = #colorLiteral(red: 0.6920366883, green: 0.6920366883, blue: 0.6920366883, alpha: 1)
        label.text = lbl
        label.frame = CGRect(x: 8, y: 8, width: view.frame.size.width-140, height: 15)
        label.font = UIFont(name:"System", size: 11)
        boton.frame = CGRect(x: view.frame.size.width-140, y: 8, width: 140, height: 15)
        boton.setTitle(btn, for: .normal)
        boton.titleLabel?.font = UIFont(name:"System", size: 11)
        boton.setTitleColor(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), for: .normal)
        boton.addTarget(self, action: #selector(update(sender:)), for: .touchUpInside)
        vistainterna.addSubview(label)
        vistainterna.addSubview(boton)
    }
    @objc func refresh(sender:AnyObject) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.refreshControl.endRefreshing()
        }
    }
    @objc func update (sender:AnyObject) {
        
        if (boton.titleLabel?.text == "Más recientes ▼") {
            boton.setTitle("Relevancia ▼", for: .normal)
            label.text = "20 empleos en Perú"
            tableview.reloadData()
        } else {
            boton.setTitle("Más recientes ▼", for: .normal)
            label.text = "507 empleos en Perú"
            tableview.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        return vistainterna
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

extension ViewController : UIScrollViewDelegate {
    
    
}
