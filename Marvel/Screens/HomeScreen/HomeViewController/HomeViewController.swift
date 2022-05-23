//
//  HomeViewController.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit
import Motion

internal final class HomeViewController: UIViewController {
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var safeAreaView: UIView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var characterTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var contentTexFieldView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var executeSearchButton: UIButton!
    @IBOutlet weak var eraseSearchButton: UIButton!
    
    
    //MARK: - VIPER dependencies
    var presenter: HomePresenterInterface!
    
    //MARK: Variables
    let listCellIdentificate = "ListCell"
    var constructorLoadingLottie: ConstructorLoading?
    var tap: UITapGestureRecognizer!
    
    //MARK: - UIViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setUpView(viewController: self)
        setUpTapView(tapView: self.view)
        isMotionEnabled = true
        logoImageView.motionIdentifier = "logo"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.showList()
    }
    
    //MARK: SETUP TAP VIEW
    private func setUpTapView(tapView: UIView) {
        self.tap = UITapGestureRecognizer(target: self, action: #selector(self.tapClose))
        tap.cancelsTouchesInView = false
        tapView.addGestureRecognizer(tap)
    }
    
    //MARK: TAP CLOSE ACTION
    @objc func tapClose() {
        view.endEditing(true)
    }
    
    //MARK: Actions
    @IBAction func updateAction(_ sender: Any) {
        presenter.hideList()
        presenter.wireframe.updateButtonWhite()
        presenter.getCharacterList(view: self, limit: "20", text: searchTextField.text ?? "")
    }
    
    @IBAction func searchAction(_ sender: Any) {
        var show = false
        (searchViewHeightConstraint.constant == 0) ? (show = true) : (show = false)
        presenter.showSearchBar(show: show)
    }
    
    @IBAction func executeSearchAction(_ sender: Any) {
        self.view.endEditing(true)
        presenter.getCharacterList(view: self, limit: "20", text: searchTextField.text ?? "")
    }
    
    @IBAction func eraseSearchAction(_ sender: Any) {
        searchTextField.text = nil
        presenter.getCharacterList(view: self, limit: "20", text: searchTextField.text ?? "")
    }
}

//MARK: - ViewInterface Protocol
extension HomeViewController: HomeViewInterface {
    func startLoadingLottie() {
        constructorLoadingLottie = ConstructorLoading(frame: self.view.frame)
        constructorLoadingLottie?.showLoading(originViewController: self)
    }
    
    func stopLoadingLottie() {
        constructorLoadingLottie?.stopLoading()
    }
    
    func showError(textError: String) {
        stopLoadingLottie()
        characterTableView.isScrollEnabled = true
        presenter.wireframe.updateButtonRed()
        presenter.showList()
        presenter.router.goToAlertScreen(textError: textError)
    }
    
    func reloadTableView() {
        characterTableView.reloadData()
        characterTableView.isScrollEnabled = true
        presenter.wireframe.updateButtonRed()
        presenter.showList()
    }
    
    func goToDescriptionScreen(text: String) {
        presenter.goToDescriptionScreen(text: text)
    }
}

//MARK: - TableView Delegate, Data Source
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return List.sharedInstance.characterList?.data?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: listCellIdentificate , for: indexPath) as! ListTableViewCell
        (cell as! ListTableViewCell).delegate = self
        cell.motionIdentifier = "motionId\(indexPath.row)"
        
        if let list = List.sharedInstance.characterList?.data?.results {
            (cell as! ListTableViewCell).setInfo(character: list[indexPath.row])
            (cell as! ListTableViewCell).descriptionText = list[indexPath.row].description
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let list = List.sharedInstance.characterList?.data?.results {
            if let id = list[indexPath.row].id {
                presenter.goToDetail(characterId: id, motionId: "motionId\(indexPath.row)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == List.sharedInstance.characterList?.data?.results?.count ?? 0 {
            var count = (List.sharedInstance.characterList?.data?.results?.count ?? 0) + 20
            if count > 80 {
                count = 100
            }
            characterTableView.isScrollEnabled = false
            if count == 100 {
                characterTableView.isScrollEnabled = true
            } else {
                if let total = List.sharedInstance.characterList?.data?.total {
                    (count > total) ? (characterTableView.isScrollEnabled = true) : (presenter.getCharacterList(view: self, limit: String(count), text: searchTextField.text ?? ""))
                }
            }
        }
    }
}

//MARK: - TextField Delegate
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        presenter.getCharacterList(view: self, limit: "20", text: searchTextField.text ?? "")
        return false
    }
}

