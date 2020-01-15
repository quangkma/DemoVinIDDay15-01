//  ListMonHocViewController.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
import UIKit
import  Alamofire
class ListMonHocViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var listMH = [Subject]()
    
    let headers: HTTPHeaders = ["Authorization": UserDefaults.standard.string(forKey: "token") ?? ""]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getListMH()
        title = CustomLocalizable.titlteListMonhoc.loadValue()  
    }
    
    func setupTableView(){
        
        tableView.register(UINib(nibName: "ListMochocTableViewCell", bundle: nil), forCellReuseIdentifier: "ListMochocTableViewCell")
    }
    
    func getListMH(){
        let url = "http://34.80.70.61/api/subjects"
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseObject { [weak self] (response: DataResponse<APIList>) in
            guard let strongSelf = self, let res = response.result.value else { return }
            strongSelf.listMH = res.subjects
            strongSelf.tableView.reloadData()
        }
    }
}


extension ListMonHocViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMH.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListMochocTableViewCell", for: indexPath) as! ListMochocTableViewCell
        cell.lbNameMH?.text = listMH[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcExam = ListExamViewController()
        vcExam.idExam = listMH[indexPath.row].id
        navigationController?.pushViewController(vcExam, animated: true)
        
    }
}
