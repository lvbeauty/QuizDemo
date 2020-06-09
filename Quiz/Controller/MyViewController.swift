//
//  MyTableViewController.swift
//  Quiz
//
//  Created by Tong Yi on 6/4/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
//    var questions: [Question] = []
    var question = ""
    var options = [String]()
    var selection: (([String]) -> Void)? = nil
    
   
    private let reuseIdentifier = "cell"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp()
    {
        questionLabel.text = question
        self.tableView.reloadData()
        tableView.tableFooterView = UIView()
    }
    
    //MARK: - DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = dequeueCell(in: tableView)
        cell.textLabel?.text = options[indexPath.row]
        return cell
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//        return cell
    }
    
    //MARK: - Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selection?(selectedOptions(in: tableView))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        if tableView.allowsMultipleSelection
        {
            selection?(selectedOptions(in: tableView))
        }
    }
    
    //MARK: - Helpers
    private func selectedOptions(in tableView: UITableView) -> [String]
    {
        guard let indexPaths = tableView.indexPathsForSelectedRows else { return [] }
        return indexPaths.map {options[$0.row]}
    }
    
    private func dequeueCell(in tableView: UITableView) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        {
            return cell
        }
        else
        {
            return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        }
    }

    @IBAction func previousButtonTapped(_ sender: Any)
    {
        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any)
    {
        
    }
    
    
}
