//
//  SecondViewController.swift
//  test
//
//  Created by Юрий Ни on 21.07.2020.
//  Copyright © 2020 Yura Ni. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var idTitle: UILabel!
    
    var text:String = ""
    var urlImage:String = ""
    var variants:data? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        nameLabel.text = text
        // Do any additional setup after loading the view.
    }
    deinit {
        print("Second view")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let url = URL(string: urlImage) else {
            return
        }
        loadImageFrom(url: url, completionHandler: {[weak self] (res) in
            self?.imageView.image = UIImage(cgImage: res.cgImage!)
        })
    }
        func loadImageFrom(url: URL, completionHandler:@escaping(UIImage)->()) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            completionHandler(image)
                        }
                    }
                }
            }
        }
    fileprivate func setupTableView(){
        tableView.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.id)
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = variants?.variants?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.id, for: indexPath)
        cell.textLabel?.text = "\(variants?.variants?[indexPath.row].id ?? 0)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idTitle.text = "ID:\(variants?.variants?[indexPath.row].id ?? 0)"
        nameLabel.text = variants?.variants?[indexPath.row].text
    }
}
