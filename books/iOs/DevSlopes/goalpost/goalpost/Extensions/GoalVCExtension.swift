//
//  GoalVCExtension.swift
//  goalpost
//
//  Created by Ahmed Sengab on 12/24/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
import CoreData

extension GoalsVC: UITableViewDelegate,UITableViewDataSource
{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            fetchCoreDataObjects()
            self.goalsTableView.reloadData()
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func fetchCoreDataObjects()
    {
        self.fetch { (Success) in
            if (Success)
            {
                if (goals.count > 0)
                {
                    self.goalsTableView.isHidden = false
                }
                else { self.goalsTableView.isHidden = true }
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = goalsTableView.dequeueReusableCell(withIdentifier: GOAL_CELL, for: indexPath) as? GoalCell else { return GoalCell() }
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
   
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.removeAtGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            self.goalsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setProgress(atIndex: indexPath)
            self.goalsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.6509803922, blue: 0.137254902, alpha: 0.7033390411)
        return [deleteAction,addAction]
    }
    func fetch(completion: (_ complete: Bool) -> ())
    {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            goals = try managedContext.fetch(fetchRequest)
            print("fetched successfuly")
            print(goals.count)
            completion(true)
        }
        catch
        {
            debugPrint("couldnot fetch \(error.localizedDescription)")
            completion(false)
        }
    }
    func removeAtGoal(atIndexPath indexPath: IndexPath)
    {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(goals[indexPath.row])
        do {
            try managedContext.save()
            print("removed")
        }
        catch {
            debugPrint("Couldnot delete \(error.localizedDescription)")
        }
        
    }
    func setProgress(atIndex indexPath: IndexPath)
    {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue{
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        }
        else {
            return
        }
        do {
            try managedContext.save()
        }
        catch {
            debugPrint("couldnot set progess\(error.localizedDescription)")
        }
    }
    
}
