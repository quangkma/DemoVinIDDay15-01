//  QuizViewController.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
import UIKit
import  Alamofire
import AlamofireObjectMapper
import ObjectMapper


class QuizViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countAnswerLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    
    let headers: HTTPHeaders = ["Authorization": UserDefaults.standard.string(forKey: "token") ?? ""]
    var listQuizz = [Questions]()
    var idQuestion: Int?
    var listAnswer = [AswerQuestion]()
    var idAnswer:Int?
    var idExam: Int?
    var numberOfQuestion: Int {
        return listQuizz.count
    }
    
    var score: APISuscess?
    var currentIndexQuestion: Int = 0
    var currentQuestion: Questions?
    var countOption: Int = 4
    var seconds = 60
    var timer: Timer!
    var dem: Int = 0
    var tongThoiGian: Int = 0
    var answers: APIPostAnswers?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getQuizz(idExam ?? 0)
        currentIndexQuestion = 0
        postNopbai()
        setTime()
        swipe()
        answers = APIPostAnswers()
        answers?.id = idExam
         countAnswerLabel.text = "\(currentIndexQuestion+1)/\(numberOfQuestion)"
    }
    
    func setupTableView(){
         tableView.register(UINib(nibName: "QuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionTableViewCell")
         tableView.register(UINib(nibName: "AnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswerTableViewCell")
     }
     
    
    func setTime(){
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
       
    }
    
    func swipe(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
               leftSwipe.direction = .left
               view.addGestureRecognizer(leftSwipe)
               let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
               rightSwipe.direction = .right
               view.addGestureRecognizer(rightSwipe)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(listQuizz.count)
        currentQuestion = listQuizz.first
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 150
        tableView.reloadData()
    }
    
    @objc func runTimer(){
        seconds -= 1
        navigationItem.title = String(dem)
        if seconds == 0 {
            self.timer.invalidate()
            let alert = UIAlertController(title: "Quiz App", message: "Thời gian làm bài đã hết!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
                guard let strongSelf = self else { return }
                strongSelf.answers?.spenttime = strongSelf.tongThoiGian
                strongSelf.tableView.reloadData()
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func postNopbai(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Nộp bài", style: .done, target: self, action: #selector(endedFunc))
    }
    
    @objc func endedFunc(){
        let alert = UIAlertController(title: "Quiz App", message: "Bạn có chắc chắn muốn kết thúc", preferredStyle: .alert)
        let action = UIAlertAction(title: "Đồng ý", style: .default) { [weak self] (_) in
            guard let strongSelf = self else { return }
            strongSelf.answers?.spenttime = strongSelf.seconds
            strongSelf.tableView.reloadData()
            if let answer = strongSelf.answers {
                strongSelf.nopBai(ans: answer)
            }

        }
        let cancel = UIAlertAction(title: "Huỷ", style: .cancel)
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
 
    func getQuizz(_ id: Int){
        let url = "http://34.80.70.61/api/exams/\(id)/test"
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseObject { [weak self] (response: DataResponse<APIQuizz>) in
            guard let strongSelf = self, let res = response.result.value else { return }
            strongSelf.dem = res.timeallow ?? 0
            strongSelf.tongThoiGian = res.timeallow ?? 0
            strongSelf.listQuizz = res.questions
            print("abc: \(res.questions.count)")
            strongSelf.tableView.reloadData()
        }
    }
 
    func nopBai(ans: APIPostAnswers){
          
          let params = [
            "id" : ans.id ?? 0,
            "spent_time": 300,//ans.spenttime ?? 0,
            "answered_questions": ans.answeredquestions.map({ $0.toJSON() })
          ] as [String : AnyObject]
          let url = "http://34.80.70.61/api/exams/\(ans.id ?? 0)"
          print("url: \(url)")
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseObject { [weak self] (response: DataResponse<APISuscess>) in
            guard let _ = self, let _ = response.result.value else { return }
//              print(res.score)
              if response.response?.statusCode == 200 {
                guard let strongSelf = self, let res = response.result.value else { return }
//                let data = res.score
//                  print(res.score ?? 0)
                  print("Request thành công")
                let vcScore = ScoreViewController()
                    vcScore.scores = res
                vcScore.modalPresentationStyle = .fullScreen
                strongSelf.present(vcScore, animated: true, completion:nil)
              }
          }
      }
    @IBAction func backPress(_ sender: Any) {
        previousAnswer()
    }
    
    @IBAction func nextPress(_ sender: Any) {
        nextAnswer()
    }
    
    @objc func swipeLeft(){
        if currentIndexQuestion != numberOfQuestion - 1 {
            nextAnswer()
        }
    }
    
    @objc func swipeRight(){
        if currentIndexQuestion > 0 {
            previousAnswer()
        }
    }
    
    func nextAnswer(){
        print("nextAnswer")
 
        previousButton.isEnabled = true
        currentIndexQuestion += 1
        if currentIndexQuestion == numberOfQuestion - 1 {
            nextButton.isEnabled = false
        }
        print(currentIndexQuestion, numberOfQuestion)
        countAnswerLabel.text = "\(currentIndexQuestion + 1)/\(numberOfQuestion)"
        currentQuestion = listQuizz[currentIndexQuestion]
        countOption = currentQuestion?.questionanswers.count ?? 0
        tableView.reloadData()
    }
    
    func previousAnswer(){
        print("previousAnswer")
        nextButton.isEnabled = true
        currentIndexQuestion -= 1
        if currentIndexQuestion <= 0 {
            currentIndexQuestion = 0
            previousButton.isEnabled = false
        }
        countAnswerLabel.text = "\(currentIndexQuestion + 1)/\(numberOfQuestion)"
        currentQuestion = listQuizz[currentIndexQuestion]
        countOption = currentQuestion?.questionanswers.count ?? 0
        tableView.reloadData()
    }
}


extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + countOption
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell", for: indexPath) as! QuestionTableViewCell
            cell.questionLabel.text = currentQuestion?.contentQuestion ?? ""
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell", for: indexPath) as! AnswerTableViewCell
//                        cell.answerLabel.text = currentQuestion?.questionanswers[indexPath.row - 1].contentAswers
            cell.answer = currentQuestion?.questionanswers[indexPath.row - 1]
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for item in currentQuestion!.questionanswers {
            item.isSelected = false
        }
        currentQuestion?.questionanswers[indexPath.row - 1].isSelected = true
        
        let answeredQuestions = AnsweredQuestions()
        answeredQuestions.id = currentQuestion?.idQuestion
        answeredQuestions.answerid = currentQuestion?.questionanswers[indexPath.row].idAswers
        answers?.answeredquestions.append(answeredQuestions)
        
        tableView.reloadData()
    }
}

