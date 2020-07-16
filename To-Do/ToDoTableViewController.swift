//
//  ToDoTableViewController.swift
//  To-Do
//
//  Created by Ria M on 7/13/20.
//  Copyright © 2020 Ria Manathkar. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var toDos : [ToDoCD] = []
    
    override func viewDidLoad()
       {
           super.viewDidLoad()

           getToDos()
           //toDos = createToDos()
       }
    
    override func viewWillAppear(_ animated: Bool) {
      getToDos()
    }

   /* func createToDos() -> [ToDo]
    {

      let swift = ToDo()
      swift.name = "Learn Swift"
      swift.important = true

      let dog = ToDo()
      dog.name = "Walk the Dog"
      // important is set to false by default

      return [swift, dog]
    }
 */
    func getToDos() {
         if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
           
           if let coreDataToDos = try? context.fetch(ToDoCD.fetchRequest()) as? [ToDoCD] {
                toDos = coreDataToDos
                   tableView.reloadData()
               
           }

         }
       }
    

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

      let toDo = toDos[indexPath.row]
        if let name = toDo.name{
            
      if toDo.important {
        cell.textLabel?.text = "❗️" + name
      } else {
        cell.textLabel?.text = toDo.name
      }
        }
      return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

      // this gives us a single ToDo
      let toDo = toDos[indexPath.row]

      performSegue(withIdentifier: "moveToComplete", sender: toDo)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let addVC = segue.destination as? AddToDOViewController {
        addVC.previousVC = self
      }
        if let completeVC = segue.destination as? CompleteToDOViewController {
        if let toDo = sender as? ToDoCD {
          completeVC.selectedToDo = toDo
          completeVC.previousVC = self
    }
    
    

}
}
}


