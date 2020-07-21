//
//  ViewController.swift
//  test
//
//  Created by Юрий Ни on 21.07.2020.
//  Copyright © 2020 Yura Ni. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    let urlString = "https://pryaniky.com/static/json/sample.json"
    var dataOrigin:jsonData? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        request(urlString: urlString)
    }
    
    func request(urlString:String){
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error:\(error)")
                    return
                }
                guard let data = data else {return}
                do{
                    let d = try JSONDecoder().decode(jsonData.self, from: data)
                    self.dataOrigin = d
                    self.tableView.reloadData()
                }catch let jsonError{
                    print("Failed to decode JSON", jsonError)
                }
            }
        }.resume()
    }
    
    fileprivate func setupTableView(){
        tableView.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.id)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataOrigin?.data.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = dataOrigin?.data[indexPath.row].name!
        let customCell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.id, for: indexPath) as! MyTableViewCell
        customCell.configure(with: title!)
        return customCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = dataOrigin?.data[indexPath.row].data?.text
        let image = dataOrigin?.data[indexPath.row].data?.url
        let variants = dataOrigin?.data[indexPath.row].data
        let vc = storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController
        navigationController?.pushViewController(vc!, animated: true)
        vc?.text = text ?? ""
        vc?.urlImage = image ?? ""
        vc?.variants = variants
    }
}
