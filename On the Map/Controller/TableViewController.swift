//
//  TableViewController.swift
//  On the Map
//
//  Created by Ahmed Maad on 10/20/20.
//  Copyright © 2020 Next Trend. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var numberOfStudents = 0
    var retrievedStudentsData: [StudentData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        ParseAPIHandler.getStudentLocation(completion: handleGetStudentData(studentsData:error:))
    }
    
    func handleGetStudentData(studentsData: [StudentData], error: Error?){
        if studentsData.count > 0{
            print("Student data request is successful from table view")
            DispatchQueue.main.async {
                self.numberOfStudents = studentsData.count
                self.retrievedStudentsData = studentsData
                self.tableView.reloadData()
            }
        }
        else{
            print("Data is returned empty with error: ", error?.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfStudents
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        let data = retrievedStudentsData[indexPath.row]
        cell.textLabel?.text = data.firstName + " " + data.lastName
        cell.detailTextLabel?.text = data.mediaURL
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = retrievedStudentsData[indexPath.row].mediaURL
        UIApplication.shared.open(URL(string: urlString)!)
    }
    
}
