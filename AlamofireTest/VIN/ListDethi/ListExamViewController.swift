//  ListExamViewController.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.

import UIKit
import Alamofire
import AlamofireObjectMapper
class ListExamViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var idExam: Int?
    var listExam = [Exams]()
    let headers: HTTPHeaders = ["Authorization": UserDefaults.standard.string(forKey: "token") ?? ""]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        print(idExam ?? 0)
        getListExam(idExam ?? 0)
        title = CustomLocalizable.titleListExam.loadValue()
    }
    
    func setupTableView(){
        
        tableView.register(UINib(nibName: "ListExamTableViewCell", bundle: nil), forCellReuseIdentifier: "ListExamTableViewCell")
    }
    
    func getListExam(_ id: Int){
        let url = "http://34.80.70.61/api/subjects/\(id)/exams"
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseObject { [weak self] (response: DataResponse<APIListExam>) in
            guard let strongSelf = self, let res = response.result.value else { return }
            strongSelf.listExam = res.exams
            strongSelf.tableView.reloadData()
        }
    }
    
}
extension ListExamViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listExam.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListExamTableViewCell", for: indexPath) as! ListExamTableViewCell
        cell.nameExam?.text = listExam[indexPath.row].name
        cell.numberQuestion?.text = String("\(listExam[indexPath.row].questionscount!) Câu")
        cell.timeExam?.text = String("\(listExam[indexPath.row].timeallow!) phút")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcQuizz = QuizViewController()
        vcQuizz.idExam = listExam[indexPath.row].id
        print(listExam[indexPath.row].id ?? 0)
        navigationController?.pushViewController(vcQuizz, animated: true)
    }
}

