//
//  ViewController2.swift
//  bein Tester
//
//  Created by Yagiz Ugur on 27.06.2019.
//  Copyright © 2019 Yagimutsu. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

var langArr: Array<String> = []
var scheme = ""
var host = ""
var path1 = "none/"
var path2 = "none/"
var path3 = "none"
var strURL = "none"
var application = UIApplication.shared
var URLforApp = URL(string: strURL)!
let URL2 = URL(string: "http://connect-au.apac.beiniz.biz/")!
var isTestButtonPressed = false

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Change Top
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Animation for Cells
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1,options: .curveEaseIn, animations: {self.tableView.layoutIfNeeded()})
    }
    
    // MARK: Back Button
    var backBut: UIButton = {
        
        let backButton = UIButton(frame: CGRect(x: 15, y: 34, width: 35, height: 35))
        
        backButton.setTitle("<", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 26)
        backButton.titleLabel?.textAlignment = .center
        //backButton.tintColor = .red
        
        let circleShape = CAShapeLayer()
        circleShape.path = UIBezierPath(ovalIn: CGRect(x: 1, y: 2, width: 35, height: 35)).cgPath;
        circleShape.fillColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5).cgColor
        backButton.layer.addSublayer(circleShape)
        
        return backButton
    }()
    
    // MARK: Test Button
    var testButton: UIButton = {
        
        var button = UIButton(frame: CGRect(x:280, y: 570, width: 75, height: 40))
        
        button.setTitle("Test", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 94/255, green: 45/255, blue: 144/255, alpha: 1)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Light", size: 26)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 5
        //button.alpha = 0
        //Shadow
        button.layer.shadowOffset = CGSize(width: 5,height: 5)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.53
        button.layer.shadowRadius = 5
        //button.isEnabled = false
    
        return button
    }()


    // MARK: Top View Label
    var headLabel:UILabel = {
        
        var label = UILabel(frame: CGRect(x: 65, y: 33, width: 250, height: 35))
        
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 32)
        
        return label
    }()
    
    // MARK: Top View
    fileprivate let topView: UIView = {
        
        let tV = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 100))
        
        // Gradient
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = tV.bounds
        gradientLayer.colors = [UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor,UIColor(red: 94/255, green: 45/255, blue: 144/255, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        tV.layer.addSublayer(gradientLayer)
        
        return tV
    }()
    
    //MARK: Table View
    
    let tableView: UITableView = {
        let tV = UITableView()
        tV.backgroundColor = UIColor.white
        tV.translatesAutoresizingMaskIntoConstraints = false
        tV.separatorStyle = .none
        return tV
    }()
    
    //MARK: Back Button Function
    @objc func backButtonClicked(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Test Button Function
    @objc func testButtonClicked(sender: UIButton){
        
        URLforApp = URL(string: strURL)!
        
        let alertFailToSend = UIAlertController(title: "Begin Test ?", message: "Are you sure to test: \(URLforApp)", preferredStyle: .alert)
        
        print(strURL)
        alertFailToSend.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        alertFailToSend.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            if application.canOpenURL(URLforApp){
            application.open(URLforApp, options: [:], completionHandler: nil)
                print(URLforApp)
                
        } else {
            
                let alertFailToSend2 = UIAlertController(title: "App cannot be opened!", message: "\(URLforApp)", preferredStyle: .alert)
                
            
                alertFailToSend2.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                
                self.present(alertFailToSend2, animated: true)
        
            }
        }))
        self.present(alertFailToSend, animated: true)
    }
    
    //MARK: Setup View
    func setupTableView(viewTable: UITableView, viewTop: UIView) {
        
        viewTable.register(TableViewCell.self, forCellReuseIdentifier: "cellId")
        viewTable.delegate = self
        viewTable.dataSource = self
        backBut.addTarget(self, action: #selector(self.backButtonClicked), for: .touchUpInside)
        
        testButton.addTarget(self, action: #selector(self.testButtonClicked), for: .touchUpInside)
        
        viewTop.addSubview(headLabel)
        viewTop.addSubview(backBut)
        
        view.addSubview(viewTop)
        view.addSubview(viewTable)
        view.addSubview(testButton)
        
        NSLayoutConstraint.activate([
            viewTable.topAnchor.constraint(equalTo: viewTop.bottomAnchor),
            viewTable.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            viewTable.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            viewTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
    }
    
    var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    //MARK: Count Attributes of JSON
    func countAttsOfJSON(data: App) -> Int {
        var countAtt = 0
        
        if data.environments.isEmpty == false { countAtt += 1
            if data.availableCountries?.isEmpty == false { countAtt += 2}
        }
        
        return countAtt
    }
    
    //MARK: Change Alpha Value of Test Button
    func changeAlphaValueOfTestButton(){
        if testButton.alpha == 0 {
            testButton.alpha = 1
        }
    }
    
    let cellArr = [
        "Environments",
        "Countries",
        "Language"
    ]
    
    //MARK: Obtain Languages
    func getLanguagesOfCountries (data: App) -> Array<Any> {
        var arr: Array<Any> = []
        var countEN_US = 0
        for i in 0...data.availableCountries!.count - 1 {
            for j in 0...data.availableCountries![i].languages.count - 1 {
                
                if data.availableCountries![i].languages[j].locale == "en-US" {
                    countEN_US += 1
                    if (countEN_US == 1 ){
                        arr.append(data.availableCountries![i].languages[j].locale)
                    }
                } else {
                    arr.append(data.availableCountries![i].languages[j].locale)
                }
            }
        }
        
        return arr
        
    }
    
    //MARK: Table View Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cellCount = 0
        
        if appNameData == jsonAppDatas.apps[0].appName {
            cellCount = countAttsOfJSON(data: jsonAppDatas.apps[0])
        } else if appNameData == jsonAppDatas.apps[1].appName {
            cellCount = countAttsOfJSON(data: jsonAppDatas.apps[1])
        } else if appNameData == jsonAppDatas.apps[2].appName {
            cellCount = countAttsOfJSON(data: jsonAppDatas.apps[2])
        }
        
        return cellCount
    }
    
    //MARK: Table View Cell for Row At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? TableViewCell {
            
            if appNameData == jsonAppDatas.apps[0].appName {
                cell.contentLabel.text = cellArr[indexPath.row]
                if indexPath.row == 0 {
                    cell.selectableCollectionView.tag = 0
                    cvArr.append(cell.selectableCollectionView)
                    
                } else if indexPath.row == 1 {
                    cell.selectableCollectionView.tag = 1
                    cvArr.append(cell.selectableCollectionView)
                } else if indexPath.row == 2 {
                    cell.selectableCollectionView.tag = 2
                    cvArr.append(cell.selectableCollectionView)
                }
                
            } else if appNameData == jsonAppDatas.apps[1].appName {
                cell.contentLabel.text = cellArr[indexPath.row]
                cell.selectableCollectionView.tag = 0
            } else if appNameData == jsonAppDatas.apps[2].appName {
                cell.contentLabel.text = cellArr[indexPath.row]
                cell.selectableCollectionView.tag = 0
            }
            
            return cell
            
        }

        return UITableViewCell()
        
    }
    
    //MARK: Table View Row Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    //MARK: Table View Did Select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell number \(indexPath.row) selected.")
        //testButton.alpha = 1
    }
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        headLabel.text = appNameData
        
        setupTableView(viewTable: tableView, viewTop: topView)
        langArr = getLanguagesOfCountries(data: jsonAppDatas.apps[0]) as! Array<String>
    
        tableView.reloadData()
    
    }
    
}
