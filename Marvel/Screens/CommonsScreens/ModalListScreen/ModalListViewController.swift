//
//  ModalListViewController.swift
//  Marvel
//
//  Created by RFG023ES on 23/5/22.
//

import UIKit

enum ListType {
    case comic
    case story
    case event
    case serie
}

class ModalListViewController: UIViewController {
    
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    
    //MARK: Variables
    var type: ListType?
    var arrayList: [String]?

    //MARK: - UIViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpView()
    }
    
    //MARK: - Functions
    func setUpView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        modalView.layer.cornerRadius = 4
        modalView.layer.borderWidth = 2
        modalView.layer.borderColor = Colors.redMarvelColor.cgColor
        modalView.layer.masksToBounds = true
        
        titleView.backgroundColor = Colors.redMarvelColor
        titleLabel.font = Fonts.robotoBlack20
        titleLabel.textColor = .white
        
        var title = ""
        if let typeModal = type {
            switch typeModal {
            case .comic:
                title = "COMICS"
            case .story:
                title = "STORIES"
            case .event:
                title = "EVENTS"
            case .serie:
                title = "SERIES"
            }
        }
        
        titleLabel.text = title
        
        closeButton.backgroundColor = Colors.darkBackgroundColor
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.setTitle("Close", for: .normal)
    }
    
    //MARK: - Actions
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

//MARK: - TableView Delegate, Data source
extension ModalListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.font = Fonts.robotoRegular15
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.minimumScaleFactor = 0.5
        cell.textLabel?.text = arrayList?[indexPath.row]
        
        return cell
    }
}
