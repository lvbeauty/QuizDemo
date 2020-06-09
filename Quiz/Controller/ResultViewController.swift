//
//  SecondViewController.swift
//  Quiz
//
//  Created by Tong Yi on 6/4/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var summary = ""
    var answers = [PresentableAnswer]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        summaryLabel.text = summary
//        tableView.register(CorrectAnswerCell.self)
//        tableView.register(WrongAnswerCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let answer = answers[indexPath.row]
        if answer.wrongAnswer == nil
        {
            return correctAnswerCell(for: answer)
        }
        return wrongAnswerCell(for: answer)
    }
    
    //MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return answers[indexPath.row].wrongAnswer == nil ? 75 : 100
    }
    
    private func correctAnswerCell(for answer: PresentableAnswer) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(CorrectAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }
    
    private func wrongAnswerCell(for answer: PresentableAnswer) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(WrongAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        cell.wrongAnswerLabel.text = answer.wrongAnswer
        return cell
    }

    @IBAction func retakeButtonTapped(_ sender: Any)
    {
        
    }
}
