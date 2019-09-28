//
//  TableViewCell.swift
//  bein Tester
//
//  Created by Yagiz Ugur on 12.07.2019.
//  Copyright © 2019 Yagimutsu. All rights reserved.
//

import UIKit

var selectedLabel = ""
var countrySelected = false
var selectedIndex: IndexPath = [0,0]

var cvArr : Array<UICollectionView> = []

class TableViewCell: UITableViewCell {
    var VC2 = ViewController2()

    // MARK: Table Cell Background
    let tableCustomCellUIView: UIView = {
        let viewCell = UIView()
        
        viewCell.layer.masksToBounds = false
        viewCell.translatesAutoresizingMaskIntoConstraints = false
        viewCell.backgroundColor = UIColor(red: 94/255, green: 45/255, blue: 144/255, alpha: 1)
        viewCell.layer.cornerRadius = 5
        
        //Shadow
        viewCell.layer.shadowOffset = CGSize(width: 5,height: 5)
        viewCell.layer.shadowColor = UIColor.black.cgColor
        viewCell.layer.shadowOpacity = 0.53
        viewCell.layer.shadowRadius = 5
        
        return viewCell
    }()

    //Items
    
    // MARK: Table Cell Label
    var contentLabel: UILabel = {
        
        var label = UILabel(frame: CGRect(x: 30, y: 25, width: 100, height: 25))
        //label.text = "Deneme"
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Medium", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        //Shadow
        label.layer.shadowOffset = CGSize(width: 5,height: 5)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.53
        label.layer.shadowRadius = 5
        return label
        
    }()
    
    // MARK: Table Cell Collection View
     var selectableCollectionView: UICollectionView = {
        let  layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "selection")
        cv.allowsSelection = true
        
        cv.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        cv.layer.cornerRadius = 5
        //Shadow
        cv.layer.shadowOffset = CGSize(width: 5,height: 5)
        cv.layer.shadowColor = UIColor.black.cgColor
        cv.layer.shadowOpacity = 0.53
        cv.layer.shadowRadius = 5
        
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        
    }
    
    func setupView() {
        
        addSubview(tableCustomCellUIView)
        tableCustomCellUIView.addSubview(contentLabel)
        tableCustomCellUIView.addSubview(selectableCollectionView)
        
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            
            tableCustomCellUIView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            tableCustomCellUIView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            tableCustomCellUIView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            tableCustomCellUIView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
            ])
        
        contentLabel.topAnchor.constraint(equalTo: tableCustomCellUIView.topAnchor, constant: 10).isActive = true
        contentLabel.leftAnchor.constraint(equalTo: tableCustomCellUIView.leftAnchor, constant: 15).isActive = true
        
        selectableCollectionView.topAnchor.constraint(equalTo: tableCustomCellUIView.topAnchor, constant: 45).isActive = true
        
        selectableCollectionView.leftAnchor.constraint(equalTo: tableCustomCellUIView.leftAnchor, constant: 15).isActive = true
        
        selectableCollectionView.rightAnchor.constraint(equalTo: tableCustomCellUIView.rightAnchor, constant: -15).isActive = true
        
        selectableCollectionView.bottomAnchor.constraint(equalTo: tableCustomCellUIView.bottomAnchor, constant: -15).isActive = true
        
        selectableCollectionView.delegate = self
        selectableCollectionView.dataSource = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Obtain Language of a Selected Country
    func getLanguageOfaCountry (data:App , index: Int) {
        //var langArr2 = langArr
        langArr = []
        //langArr = []
        if countrySelected == true{
            for j in 0...data.availableCountries![index].languages.count - 1 {
                langArr.append(data.availableCountries![index].languages[j].locale)
            }
        }
    
    }
    
    func updateCollectionView(collectionView:UICollectionView,indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selection", for: indexPath) as! CollectionViewCell
        
        
        if isTestButtonPressed == true {
            collectionView.deselectItem(at: indexPath, animated: true)
            collectionView.reloadData()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.height/1.5)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 0 {
            return jsonAppDatas.apps[0].environments.count
        } else if collectionView.tag == 1 {
            return jsonAppDatas.apps[0].availableCountries!.count
        } else if collectionView.tag == 2 {
            //collectionView.reloadData()
            return langArr.count
           
        }
        
        return 0
        
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selection", for: indexPath) as! CollectionViewCell
        
        if collectionView.tag == 0 {
            cell.selectionLabel.text = jsonAppDatas.apps[0].environments[indexPath.row]
            
        } else if collectionView.tag == 1 {
            cell.selectionLabel.text = jsonAppDatas.apps[0].availableCountries![indexPath.row].code
           
        } else if collectionView.tag == 2 {
            cell.selectionLabel.text = langArr[indexPath.row]
            

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("CollectionView tag: ", collectionView.tag , ", index: \(indexPath)")
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
       
        
        if appNameData == jsonAppDatas.apps[0].appName {
            
            scheme = appNameData + "://"
            host = "connect.beinsports.com/quality/"
            
            if collectionView.tag == 0 && collectionView.cellForItem(at: indexPath)?.isSelected == true {
                
                path1 =   cell.selectionLabel.text! + "/"
                strURL = scheme + host + path1 + path2 + path3
                
            } else if collectionView.tag == 1 && collectionView.cellForItem(at: indexPath)?.isSelected == true {
                countrySelected = true
                
                selectedIndex = indexPath
                getLanguageOfaCountry(data: jsonAppDatas.apps[0], index: indexPath.row)
                //collectionView.reloadData()
                cvArr[2].reloadData()
                path2 =   cell.selectionLabel.text! + "/"
                strURL = scheme + host + path1 + path2 + path3
                
            } else if collectionView.tag == 2 && collectionView.cellForItem(at: indexPath)?.isSelected == true {
                
                path3 =   cell.selectionLabel.text!
                strURL = scheme + host + path1 + path2 + path3
            }
            
        } else if appNameData == jsonAppDatas.apps[1].appName {
            if collectionView.tag == 0 && collectionView.cellForItem(at: indexPath)?.isSelected == true {
                scheme = appNameData + "://"
                host = ""
                path1 =   cell.selectionLabel.text! + "/"
                strURL = scheme + host + path1 + path2 + path3
            }
            
        } else if appNameData == jsonAppDatas.apps[2].appName {
            if collectionView.tag == 0 && collectionView.cellForItem(at: indexPath)?.isSelected == true {
                scheme = appNameData + "://"
                host = ""
                path1 =   cell.selectionLabel.text! + "/"
                strURL = scheme + host + path1 + path2 + path3
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView.tag == 1 || collectionView.tag == 2 {
            if collectionView.cellForItem(at: indexPath)?.isSelected ?? false {
                if collectionView.tag == 1 {
                    path2 = "none/"
                    countrySelected = false
                    collectionView.deselectItem(at: indexPath, animated: true)
                    strURL = scheme + host + path1 + path2 + path3
                } else if collectionView.tag == 2 {
                    path3 = "none"
                    collectionView.deselectItem(at: indexPath, animated: true)
                    strURL = scheme + host + path1 + path2 + path3
                }
                
                return false
            }
        }
        
        return true
    }

}
