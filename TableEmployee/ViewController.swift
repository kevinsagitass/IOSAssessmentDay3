//
//  ViewController.swift
//  TableEmployee
//
//  Created by P090MMCTSE011 on 18/10/23.
//

import UIKit
import Alamofire

private let employeeURL: String = "https://dummy.restapiexample.com/api/v1/employees";

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var employees: [Employee] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(
            nibName: "EmployeeTableViewCell",
            bundle: nil
        ), forCellReuseIdentifier: "employeeTableCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    
    func getData() {
        guard let url = URL(string: employeeURL) else { return }
        
        let urlConvertible: URLConvertible = url
        
        AF.request(
            urlConvertible,
            method: .get,
            parameters: [:],
            encoding: URLEncoding.queryString,
            headers: [:]
        ).response { responseData in
            guard let data = responseData.data else { return }
            
            do {
                let employeeResponse = try JSONDecoder().decode(EmployeeResponse.self, from: data)
                
                DispatchQueue.main.async{ [weak self] in
                    self?.employees = employeeResponse.data ?? []
                    self?.tableView.reloadData()
                }
            } catch let jsonErr {
                print("Error in Decode \(jsonErr)")
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeTableCell", for: indexPath) as! EmployeeTableViewCell
        
        cell.nameLabel.text = self.employees[indexPath.row].name
        cell.ageLabel.text = String(self.employees[indexPath.row].age)
        cell.salaryLabel.text = String(self.employees[indexPath.row].salary)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}

