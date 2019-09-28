//
//  ViewController.swift
//  beIN Tester
//
//  Created by Yagiz Ugur on 26.06.2019.
//  Copyright © 2019 Yagimutsu. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

//MARK:App Data Structure

var globalVC: UIViewController = ViewController()
var appNameData = ""
var jsonAppDatas: AppDatas = AppDatas()

//var appDatas:

struct AppData {
    var img: UIImage
    var appName: String
}

//MARK:View Controller
class ViewController: UIViewController {
    var appImgData: [UIImage] = [#imageLiteral(resourceName: "bein_sports"),#imageLiteral(resourceName: "bein_connect_purple"),#imageLiteral(resourceName: "bein_connect_white"),#imageLiteral(resourceName: "bein_sports_tr"),#imageLiteral(resourceName: "bein-sports-connect")]
    var appData: [AppData] = []
    
    //MARK: Setting App Image Data and Name
    func setAppImgNameData() {
        
        for item in 0...(jsonAppDatas.apps.count - 1) {
            appData.append(AppData(img: appImgData[item], appName: jsonAppDatas.apps[item].appName))
        }
    }
    
    // MARK: Change Top
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:Top View
    fileprivate let topView: UIView = {
        
        let tV = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 100))
        
        // Gradient
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = tV.bounds
        gradientLayer.colors = [UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor,UIColor(red: 94/255, green: 45/255, blue: 144/255, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        
        // Title
        
        let appsLabel = UILabel(frame: CGRect(x: 15, y: 35, width: 314, height: 30))
        appsLabel.text = "beIN App Tester"
        appsLabel.textColor = .white
        let fontName = "SFProDisplay-Semibold"
        appsLabel.font = UIFont(name: fontName, size: (32))
        
        tV.layer.addSublayer(gradientLayer)
        tV.addSubview(appsLabel)
        
        return tV
    }()
    
    //MARK:Collection View
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "Cell")
        
        return cv
    }()
    
    //MARK:ViewDidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let myJSON = Bundle.main.url(forResource: "appdata", withExtension: "json")!
        
        do {
            let jsonData = try Data(contentsOf: myJSON)
            let json = try! JSONDecoder().decode(AppDatas.self, from: jsonData)
            
            jsonAppDatas = json
            
            print(json.apps[0].appName)
            print(json.apps[0].environments)
            print(json.apps[0].availableCountries!)
            
            
        } catch {
            print(error)
        }
        
        setAppImgNameData()
        // Realoading the collection view to show data
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        view.addSubview(topView)
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        
        topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        topView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //print(jsonAppDatas.apps[0].appName, jsonAppDatas.apps[0].environments)
        
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    //MARK:Collection View Cell Size
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 80)
    }
    
    //MARK:Number of Cells in CV
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appData.count
    }
    
    //MARK: Cell Index
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCell
        cell.data = appData[indexPath.row]
        //cell.data = beinDataModel.appData[indexPath.row]
        return cell
    }
    
    //MARK: Didselect Item At
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item number \(indexPath.row) is selected." )
        
        appNameData = appData[indexPath.row].appName
        
        self.present(ViewController2(), animated: true,completion: nil)
        
    }
    
}

//MARK:Custom Cell

class CustomCell: UICollectionViewCell {
    
    //MARK:Cell Data
    
    var data: AppData? {
        didSet {
            guard let data = data else { return }
            appImg.image = data.img
            appName.text = data.appName
        }
    }
    
    //MARK:App Image
    fileprivate let appImg: UIImageView = {
        
        let imgV = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))

        imgV.translatesAutoresizingMaskIntoConstraints = false
        imgV.contentMode = .scaleAspectFill
        imgV.clipsToBounds = false
        //imgV.layer.cornerRadius = 10
        imgV.layer.shadowColor = UIColor.black.cgColor
        imgV.layer.shadowOpacity = 1
        imgV.layer.shadowOffset = CGSize.zero
        imgV.layer.shadowRadius = 10
        imgV.layer.shadowPath = UIBezierPath(roundedRect: imgV.bounds, cornerRadius: 10).cgPath
        
        let myImgV = UIImageView(frame: imgV.bounds)
        myImgV.clipsToBounds = true
        myImgV.contentMode = .scaleAspectFill
        myImgV.layer.cornerRadius = 10
        
        
        return myImgV
    }()
    
    //MARK:App Name
    fileprivate let appName: UILabel = {
        
        let name = UILabel(frame: CGRect(x: 0, y: 60, width: 60, height: 20))
        name.textAlignment = .center
        name.textColor = .black
        name.font = UIFont(name: "SFProDisplay-Semibold", size: 10)
        
        
        return name
    }()

    //MARK:Cell Constraints
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(appImg)
        contentView.addSubview(appName)
        
        appImg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        appImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        appImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        appImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
        appName.topAnchor.constraint(equalTo: appImg.bottomAnchor).isActive = true
        appName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        appName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        appName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
